defmodule EatOutWeb.LocationController do
  use EatOutWeb, :controller

  action_fallback EatOutWeb.FallbackController

  def create(conn, %{"lat" => lat, "long" => long}) do

    url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
    <> "location="
    <> to_string(lat) <> ","
    <> to_string(long) <> "&"
    <> "radius=5000&"
    <> "type=restaurant&"
    <> "key="
    <> System.get_env("GOOGLE_API_KEY")

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        newbody = Jason.decode!(body)
        results = newbody["results"]
        conn
        |> assign(:restaurants, results)
        |> render("home.html", restaurants: results)
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.inspect("404")
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

  def home(conn, _params) do
    if !Plug.Conn.get_session(conn, :user_id) do
      redirect(conn, to: "/index")
    end

    if (conn.cookies["lat"] && conn.cookies["long"]) do
      IO.inspect("in right condition")
      lat = conn.cookies["lat"]
      long = conn.cookies["long"]

      url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
      <> "location="
      <> lat <> ","
      <> long <> "&"
      <> "radius=5000&"
      <> "type=restaurant&"
      <> "key="
      <> System.get_env("GOOGLE_API_KEY")

      case HTTPoison.get(url) do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          newbody = Jason.decode!(body)
          results = newbody["results"]
          results = Enum.map(results, fn result ->
            %{
              id: result["id"],
              name: result["name"],
              price: result["price_level"],
              address: result["vicinity"]
            }
          end)
          render(conn, "home.html", restaurants: results)
        {:ok, %HTTPoison.Response{status_code: 404}} ->
          render(conn, "home.html", restaurants: [])
        {:error, %HTTPoison.Error{reason: reason}} ->
          render(conn, "home.html", restaurants: [])
      end
    else
      render(conn, "home.html", restaurants: [])
    end
  end

end
