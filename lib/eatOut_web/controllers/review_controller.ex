defmodule EatOutWeb.ReviewController do
  use EatOutWeb, :controller

  alias EatOut.Reviews
  alias EatOut.Reviews.Review

  def index(conn, _params) do
    reviews = Reviews.list_reviews()
    render(conn, "index.html", reviews: reviews)
  end

  def new(conn, _params) do
    changeset = Reviews.change_review(%Review{})
    render(conn, "new.html", changeset: changeset)
  end

  def new(conn, %{"rest_id" => rest_id}) do
    changeset = Reviews.change_review(%Review{})
    render(conn, "new.html", changeset: changeset, rest_id: rest_id)
  end

  def create(conn, %{"review" => review_params}) do

    case Reviews.create_review(review_params) do
      {:ok, review} ->
        conn
        |> put_flash(:info, "Review created successfully.")
        |> redirect(to: Routes.user_path(conn, :show, review.user_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    review = Reviews.get_review!(id)
    render(conn, "show.html", review: review)
  end

  def edit(conn, %{"id" => id}) do
    review = Reviews.get_review!(id)
    changeset = Reviews.change_review(review)
    render(conn, "edit.html", review: review, rest_id: review.restaurant_id, changeset: changeset)
  end

  def update(conn, %{"id" => id, "review" => review_params}) do
    review = Reviews.get_review!(id)

    case Reviews.update_review(review, review_params) do
      {:ok, review} ->
        conn
        |> put_flash(:info, "Review updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, review.user_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", review: review, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    review = Reviews.get_review!(id)
    {:ok, _review} = Reviews.delete_review(review)

    conn
    |> put_flash(:info, "Review deleted successfully.")
    |> redirect(to: Routes.review_path(conn, :index))
  end

  # def reviews(conn, %{"rest_id" => rest_id}) do
  #   reviews = Reviews.get_reviews_for_restaurant(rest_id)
  #   render(conn, "index.html", reviews: reviews)
  # end

  def reviews(conn, %{"rest_id" => rest_id, "rest_name" => rest_name}) do
    reviews = Reviews.get_reviews_for_restaurant(rest_id)
    render(conn, "index.html", %{reviews: reviews, rest_name: rest_name, rest_id: rest_id})
  end

end
