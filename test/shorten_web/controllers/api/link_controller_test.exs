defmodule ShortenWeb.Api.LinkControllerTest do
  use ShortenWeb.ConnCase

  alias Shorten.Links

  @create_attrs %{
    "url" => "https://www.stord.com/"
  }

  def fixture(:link) do
    {:ok, link} = Links.find_or_create(@create_attrs)
    link
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create link" do
    test "renders link when data is valid", %{conn: conn} do
      conn = post(conn, Routes.link_path(conn, :create), link: @create_attrs)
      assert %{"shortLink" => _shortLink} = json_response(conn, 201)
    end

    test "returns existing link when already created", %{conn: conn} do
      link = fixture(:link)
      conn = post(conn, Routes.link_path(conn, :create), link: @create_attrs)
      shortLink = ShortenWeb.Router.Helpers.url(conn) <> "/" <> link.slug
      assert %{"shortLink" => ^shortLink} = json_response(conn, 201)
    end
  end
end
