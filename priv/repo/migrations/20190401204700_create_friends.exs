defmodule EatOut.Repo.Migrations.Friends do
  use Ecto.Migration

  def change do
    create table(:friends) do
      timestamps()
    end
    alter table(:friends) do
      add :friender_id, references(:users), null: false
      add :friendee_id, references(:users), null: false
    end
  end
end
