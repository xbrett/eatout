defmodule EatOutWeb.PageController do
  use EatOutWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
    if Plug.Conn.get_session(conn, :user_id) do
      redirect(conn, to: "/home")
    end
    render conn, "index.html"
  end

end
