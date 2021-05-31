defmodule Shorten.Links do
  import Ecto.Query, warn: false
  alias Shorten.Repo

  alias Shorten.Links.Link

  def find_or_create(attrs) do
    link = find_by_url(attrs.url)
    if is_nil(link) do
      %Link{}
      |> Link.changeset(attrs)
      |> Repo.insert()
    else
      {:ok, link}
    end
  end

  def find_by_slug(slug) do
    Repo.get_by(Link, slug: slug)
  end

  def find_by_url(url) do
    Repo.get_by(Link, url: url)
  end
end
