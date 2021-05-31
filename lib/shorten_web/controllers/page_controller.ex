defmodule ShortenWeb.PageController do
  use ShortenWeb, :controller

  alias Shorten.Links

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def link_redirect(conn, %{"slug" => slug}) do
    link = Links.find_by_slug(slug)
    redirect(conn, external: link.url)
  end
end
