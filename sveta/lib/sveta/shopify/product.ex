defmodule Sveta.Shopify.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :category, :string
    field :gender, :string
    field :part, :string
    field :product_id, :string
    field :src, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:product_id, :src, :title, :gender, :category, :part])
    |> validate_required([:product_id, :src, :title, :gender, :category, :part])
  end
end
