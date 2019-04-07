defmodule EatOut.Reviews do
  @moduledoc """
  The Reviews context.
  """

  import Ecto.Query, warn: false
  alias EatOut.Repo

  alias EatOut.Reviews.Review

  @doc """
  Returns the list of reviews.

  ## Examples

      iex> list_reviews()
      [%Review{}, ...]

  """
  def list_reviews do
    Repo.all(Review)
  end

  @doc """
  Gets a single review.

  Raises `Ecto.NoResultsError` if the Review does not exist.

  ## Examples

      iex> get_review!(123)
      %Review{}

      iex> get_review!(456)
      ** (Ecto.NoResultsError)

  """
  def get_review!(id), do: Repo.get!(Review, id)

  def get_review(id), do: Repo.get(Review, id)

  def get_reviews_for_restaurant(rest_id) do
    query = from r in Review, where: r.restaurant_id == ^rest_id
    Repo.all(query)
  end

  def get_reviews_for_user(user_id) do
    query = from r in Review, where: r.user_id == ^user_id
    Repo.all(query)
  end

  def get_restaurant_name(rest_id) do
    query = from r in Review, where: r.restaurant_id == ^rest_id, select: r.restaurant_name, limit: 1
    Repo.all(query)
  end

  def get_avg_rating_for_restaruant(rest_id) do
    query = from r in Review, where: r.restaurant_id == ^rest_id, select: r.rating
    ratings = Repo.all(query)
    count = length(ratings)

    case count do
      0 -> nil
      _ ->
        ratings
        |> List.foldl(0, fn x, acc -> x + acc end)
        |> Decimal.div(count)
        |> Decimal.round(1)
      end
  end

  @doc """
  Creates a review.

  ## Examples

      iex> create_review(%{field: value})
      {:ok, %Review{}}

      iex> create_review(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_review(attrs \\ %{}) do
    %Review{}
    |> Review.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a review.

  ## Examples

      iex> update_review(review, %{field: new_value})
      {:ok, %Review{}}

      iex> update_review(review, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_review(%Review{} = review, attrs) do
    review
    |> Review.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Review.

  ## Examples

      iex> delete_review(review)
      {:ok, %Review{}}

      iex> delete_review(review)
      {:error, %Ecto.Changeset{}}

  """
  def delete_review(%Review{} = review) do
    Repo.delete(review)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking review changes.

  ## Examples

      iex> change_review(review)
      %Ecto.Changeset{source: %Review{}}

  """
  def change_review(%Review{} = review) do
    Review.changeset(review, %{})
  end
end
