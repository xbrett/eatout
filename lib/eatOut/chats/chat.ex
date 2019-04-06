defmodule EatOut.Chats.Chat do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chats" do
    field :message, :string
    belongs_to :sender, EatOut.Users.User
    belongs_to :receiver, EatOut.Users.User

    timestamps()
  end

  @doc false
  def changeset(chat, attrs) do
    chat
    |> cast(attrs, [:message, :sender_id, :receiver_id])
    |> validate_required([:message, :sender_id, :receiver_id])
  end
end
