defmodule EatOut.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias EatOut.Repo

  alias EatOut.Users.User
  alias EatOut.Reviews.Review

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  List users except the given one

  """
  def list_others(id) do
    query  = from u in User, where: u.id != ^id
    Repo.all(query)
  end

  def list_reviews(id) do
    query = from r in Review, where: r.user_id == ^id
    Repo.all(query)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)
  def get_user(id), do: Repo.get(User, id)

  def get_user_by_email(email) do
    Repo.get_by(User, email: email)
  end

  def get_and_auth_user(email, password) do
    user = get_user_by_email(email)
    IO.inspect(user)
    case Comeonin.Argon2.check_pass(user, password) do
      {:ok, user} -> user
      _else       -> nil
    end
  end

  def get_user_for_review(review_id) do
    # select u.name
    # from u User join r Review on u.user_id = r.user_id
    # where r.review_id == ^review_id

    # query = from u in User, join: r in Review, where: u.id == r.user_id, where: r.id == ^review_id, select: u.name

    review = Repo.get_by(Review, id: review_id)
    #query = from r in Review, where: r.review_id == ^review_id, select: r.user_id
    query = from u in User, where: u.id == ^review["user_id"], select: u.name
    results = Repo.all(query)
    IO.inspect(results)
    results
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(%{"name" => name, "email" => email, "password_hash" => password}) do
    pswd = Argon2.hash_pwd_salt(password)
    %User{}
    |> User.changeset(%{"name" => name, "email" => email, "password_hash" => pswd})
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end
