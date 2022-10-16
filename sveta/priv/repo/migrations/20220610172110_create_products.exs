defmodule Sveta.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :product_id, :string
      add :src, :string
      add :title, :string
      add :gender, :string
      add :category, :string
      add :part, :string

      timestamps()
    end
  end
end
