defmodule EatOut.Friends do
  @moduledoc """
  The Friends context.
  """

  import Ecto.Query, warn: false
  alias EatOut.Repo

  alias EatOut.Friends.Friend
  alias EatOut.Users.User

  @doc """
  Returns the list of friends.

  ## Examples

      iex> list_friends()
      [%Friend{}, ...]

  """
  def list_friends do
    Repo.all(Friend)
  end

  @doc """
  List users that are not friends

  Selecting users that are not friends with the given id

  """
  def list_not_friends(id) do
    # Find the friend of this user
    query1 = from f in Friend,
                where: f.friender_id == ^id or f.friendee_id == ^id,
                select: {f.friender_id, f.friendee_id}
    friends = Repo.all(query1)

    # List of tuple -> into list
    # Make a list of user id that are friends with given id
    loi = List.foldl(friends, [id], fn x, acc ->
      acc = if elem(x, 0) != id do
        [elem(x, 0)] ++ acc
      else 
        acc
      end
      acc = if elem(x, 1) != id do
        [elem(x, 1)] ++ acc
      else 
        acc
      end
    end)
    # Find the users that are not in friends
    query2 = from u in User,
                where: not u.id in ^loi
    Repo.all(query2)
  end



  @doc """
  Gets a single friend.

  Raises `Ecto.NoResultsError` if the Friend does not exist.

  ## Examples

      iex> get_friend!(123)
      %Friend{}

      iex> get_friend!(456)
      ** (Ecto.NoResultsError)

  """
  def get_friend!(id), do: Repo.get!(Friend, id)

  def get_friend(id), do: Repo.get(Friend, id)

  @doc """
  Creates a friend.

  ## Examples

      iex> create_friend(%{field: value})
      {:ok, %Friend{}}

      iex> create_friend(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_friend(attrs \\ %{}) do
    %Friend{}
    |> Friend.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a friend.

  ## Examples

      iex> update_friend(friend, %{field: new_value})
      {:ok, %Friend{}}

      iex> update_friend(friend, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_friend(%Friend{} = friend, attrs) do
    friend
    |> Friend.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Friend.

  ## Examples

      iex> delete_friend(friend)
      {:ok, %Friend{}}

      iex> delete_friend(friend)
      {:error, %Ecto.Changeset{}}

  """
  def delete_friend(%Friend{} = friend) do
    Repo.delete(friend)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking friend changes.

  ## Examples

      iex> change_friend(friend)
      %Ecto.Changeset{source: %Friend{}}

  """
  def change_friend(%Friend{} = friend) do
    Friend.changeset(friend, %{})
  end
end
