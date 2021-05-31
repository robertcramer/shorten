defmodule ShortenWeb.PageController do
  use ShortenWeb, :controller

  alias Shorten.Links

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def link_redirect(conn, %{"slug" => slug}) do
    link = Links.find_by_slug(slug)
    if link do
      redirect(conn, external: link.url)
    else
      render(conn, ShortenWeb.ErrorView, "404.html")
    end
  end
end
