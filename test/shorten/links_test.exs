defmodule Shorten.LinksTest do
  use Shorten.DataCase

  alias Shorten.Links

  describe "links" do
    alias Shorten.Links.Link

    @valid_attrs %{"url" => "https://www.stord.com/"}
    @invalid_attrs %{"url" => "some url"}

    def link_fixture(attrs \\ %{}) do
      {:ok, link} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Links.find_or_create()
      link
    end

    test "find_or_create returns a new link" do
      assert {:ok, %Link{} = link} = Links.find_or_create(@valid_attrs)
      assert String.length(link.slug) == 8
      assert link.url == @valid_attrs["url"]
    end

    test "find_or_create returns an existing link" do
      original_link = link_fixture()
      {:ok, %Link{} = link} = Links.find_or_create(@valid_attrs)
      assert original_link == link
    end

    test "find_by_slug returns a link by slug" do
      link = link_fixture()
      assert Links.find_by_slug(link.slug).id == link.id
    end

    test "find_by_url returns a link by url" do
      link = link_fixture()
      assert Links.find_by_url(link.url) == link
    end

    test "find_or_create with invalid url returns error changeset" do
        assert {:error, _} = Links.find_or_create(@invalid_attrs)
    end
  end
end
