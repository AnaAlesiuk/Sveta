defmodule Sveta.ShopifyFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Sveta.Shopify` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        category: "some category",
        gender: "some gender",
        part: "some part",
        product_id: "some product_id",
        src: "some src",
        title: "some title"
      })
      |> Sveta.Shopify.create_product()

    product
  end
end
