defmodule Sveta.ShopifyTest do
  use Sveta.DataCase

  alias Sveta.Shopify

  describe "products" do
    alias Sveta.Shopify.Product

    import Sveta.ShopifyFixtures

    @invalid_attrs %{category: nil, gender: nil, part: nil, product_id: nil, src: nil, title: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Shopify.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Shopify.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{category: "some category", gender: "some gender", part: "some part", product_id: "some product_id", src: "some src", title: "some title"}

      assert {:ok, %Product{} = product} = Shopify.create_product(valid_attrs)
      assert product.category == "some category"
      assert product.gender == "some gender"
      assert product.part == "some part"
      assert product.product_id == "some product_id"
      assert product.src == "some src"
      assert product.title == "some title"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shopify.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{category: "some updated category", gender: "some updated gender", part: "some updated part", product_id: "some updated product_id", src: "some updated src", title: "some updated title"}

      assert {:ok, %Product{} = product} = Shopify.update_product(product, update_attrs)
      assert product.category == "some updated category"
      assert product.gender == "some updated gender"
      assert product.part == "some updated part"
      assert product.product_id == "some updated product_id"
      assert product.src == "some updated src"
      assert product.title == "some updated title"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Shopify.update_product(product, @invalid_attrs)
      assert product == Shopify.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Shopify.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Shopify.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Shopify.change_product(product)
    end
  end
end
