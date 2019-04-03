defmodule EatOut.Reviews.Review do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reviews" do
    field :comment, :string
    field :name, :string
    field :rating, :integer
    field :restaurant_id, :string
    belongs_to :user, EatOut.Users.User

    timestamps()
  end

  @doc false
  def changeset(review, attrs) do
    review
    |> cast(attrs, [:name, :comment, :rating, :restaurant_id])
    |> validate_required([:name, :comment, :rating, :restaurant_id])
  end
end
