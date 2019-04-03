defmodule EatOut.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add :name, :string, null: false
      add :comment, :text
      add :rating, :integer, null: false
      add :restaurant_id, :string, null: false
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

  end
end
