defmodule EatOut.Repo.Migrations.CreateFriends do
  use Ecto.Migration

  def change do
    create table(:friends) do
      add :friender_id, references(:users, on_delete: :delete_all), null: false
      add :friendee_id, references(:users, on_delete: :delete_all), null: false
      add :confirmed, :boolean, default: false, null: false

      timestamps()
    end

    create index(:friends, [:friender_id])
    create index(:friends, [:friendee_id])
  end
end
