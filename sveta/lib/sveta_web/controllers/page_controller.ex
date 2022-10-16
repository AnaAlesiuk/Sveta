defmodule SvetaWeb.PageController do
  use SvetaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
