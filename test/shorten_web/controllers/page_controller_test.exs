defmodule ShortenWeb.PageControllerTest do
  use ShortenWeb.ConnCase

  @get_attrs %{
    slug: "some slug"
  }

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
