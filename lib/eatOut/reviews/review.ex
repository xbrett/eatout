defmodule EatOut.Reviews.Review do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reviews" do
    field :comment, :string
    field :name, :string
    field :rating, :integer
    field :restaurant_id, :string
    field :restaurant_name, :string
    belongs_to :user, EatOut.Users.User

    timestamps()
  end

  @doc false
  def changeset(review, attrs) do
    review
    |> cast(attrs, [:name, :comment, :rating, :restaurant_id, :restaurant_name, :user_id])
    |> validate_required([:name, :comment, :rating, :restaurant_id, :restaurant_name, :user_id])
  end
end
