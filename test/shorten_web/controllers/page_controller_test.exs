defmodule ShortenWeb.PageControllerTest do
  use ShortenWeb.ConnCase

  alias Shorten.Links

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200)
  end

  describe "link redirect" do
    test "GET /:slug when slug exists", %{conn: conn} do
      {:ok, link} = Links.find_or_create(%{"url" => "https://www.stord.com/"})
      conn = get(conn, "/#{link.slug}")
      assert redirected_to(conn, 302) =~ link.url
    end

    test "GET /:slug when slug does not exist", %{conn: conn} do
      conn = get(conn, "/bad-slug")
      assert html_response(conn, 404)
    end
  end
end
