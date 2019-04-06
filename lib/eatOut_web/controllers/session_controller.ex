defmodule EatOutWeb.SessionController do
  use EatOutWeb, :controller

  def create(conn, %{"email" => email, "password" => password}) do
    IO.inspect(email)
    IO.inspect(password)
    user = EatOut.Users.get_and_auth_user(email, password)
    IO.inspect(user)
    if user do
      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Welcome back #{user.email}")
      |> redirect(to: Routes.location_path(conn, :home))
    else
      conn
      |> put_flash(:error, "Login failed.")
      |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "Logged out.")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
