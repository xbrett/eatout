defmodule EatOut.Friends.Friend do
  use Ecto.Schema
  import Ecto.Changeset

  schema "friends" do
    belongs_to :friender, EatOut.Users.User
    belongs_to :freindee, EatOut.Users.User

    timestamps()
  end

  @doc false
  def changeset(friend, attrs) do
    friend
    |> cast(attrs, [])
    |> validate_required([:friender_id, :friendee_id])
  end
end
