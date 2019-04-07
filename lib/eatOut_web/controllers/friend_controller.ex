defmodule EatOutWeb.FriendController do
  use EatOutWeb, :controller

  alias EatOut.Friends
  alias EatOut.Friends.Friend

  def index(conn, _params) do
    friends = Friends.list_friends()
    render(conn, "index.html", friends: friends)
  end

  def new(conn, _params) do
    changeset = Friends.change_friend(%Friend{})
    render(conn, "new.html", changeset: changeset, friend: false)
  end

  def create(conn, %{"friend" => friend_params}) do
    case Friends.create_friend(friend_params) do
      {:ok, _friend} ->
        conn
        |> put_flash(:info, "Friend request sent successfully.")
        |> redirect(to: Routes.friend_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, friend: false)
    end
  end

  def show(conn, %{"id" => id}) do
    friends = Friends.list_friends()
    IO.inspect(friends)
    render(conn, "show.html", friends: friends, display_id: id)
  end

  def edit(conn, %{"id" => id}) do
    friend = Friends.get_friend!(id)
    changeset = Friends.change_friend(friend)
    render(conn, "edit.html", friend: friend, changeset: changeset)
  end

  def update(conn, %{"id" => id, "friend" => friend_params}) do
    friend = Friends.get_friend!(id)
    case Friends.update_friend(friend, friend_params) do
      {:ok, _friend} ->
        conn
        |> put_flash(:info, "New friend added successfully.")
        |> redirect(to: Routes.friend_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", friend: friend, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    friend = Friends.get_friend!(id)
    {:ok, _friend} = Friends.delete_friend(friend)

    conn
    |> put_flash(:info, "Friend deleted successfully.")
    |> redirect(to: Routes.friend_path(conn, :index))
  end
end
