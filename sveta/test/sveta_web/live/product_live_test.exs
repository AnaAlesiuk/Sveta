defmodule SvetaWeb.ProductLiveTest do
  use SvetaWeb.ConnCase

  import Phoenix.LiveViewTest
  import Sveta.ShopifyFixtures

  @create_attrs %{category: "some category", gender: "some gender", part: "some part", product_id: "some product_id", src: "some src", title: "some title"}
  @update_attrs %{category: "some updated category", gender: "some updated gender", part: "some updated part", product_id: "some updated product_id", src: "some updated src", title: "some updated title"}
  @invalid_attrs %{category: nil, gender: nil, part: nil, product_id: nil, src: nil, title: nil}

  defp create_product(_) do
    product = product_fixture()
    %{product: product}
  end

  describe "Index" do
    setup [:create_product]

    test "lists all products", %{conn: conn, product: product} do
      {:ok, _index_live, html} = live(conn, Routes.product_index_path(conn, :index))

      assert html =~ "Listing Products"
      assert html =~ product.category
    end

    test "saves new product", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.product_index_path(conn, :index))

      assert index_live |> element("a", "New Product") |> render_click() =~
               "New Product"

      assert_patch(index_live, Routes.product_index_path(conn, :new))

      assert index_live
             |> form("#product-form", product: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#product-form", product: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.product_index_path(conn, :index))

      assert html =~ "Product created successfully"
      assert html =~ "some category"
    end

    test "updates product in listing", %{conn: conn, product: product} do
      {:ok, index_live, _html} = live(conn, Routes.product_index_path(conn, :index))

      assert index_live |> element("#product-#{product.id} a", "Edit") |> render_click() =~
               "Edit Product"

      assert_patch(index_live, Routes.product_index_path(conn, :edit, product))

      assert index_live
             |> form("#product-form", product: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#product-form", product: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.product_index_path(conn, :index))

      assert html =~ "Product updated successfully"
      assert html =~ "some updated category"
    end

    test "deletes product in listing", %{conn: conn, product: product} do
      {:ok, index_live, _html} = live(conn, Routes.product_index_path(conn, :index))

      assert index_live |> element("#product-#{product.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#product-#{product.id}")
    end
  end

  describe "Show" do
    setup [:create_product]

    test "displays product", %{conn: conn, product: product} do
      {:ok, _show_live, html} = live(conn, Routes.product_show_path(conn, :show, product))

      assert html =~ "Show Product"
      assert html =~ product.category
    end

    test "updates product within modal", %{conn: conn, product: product} do
      {:ok, show_live, _html} = live(conn, Routes.product_show_path(conn, :show, product))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Product"

      assert_patch(show_live, Routes.product_show_path(conn, :edit, product))

      assert show_live
             |> form("#product-form", product: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#product-form", product: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.product_show_path(conn, :show, product))

      assert html =~ "Product updated successfully"
      assert html =~ "some updated category"
    end
  end
end
