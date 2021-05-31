defmodule ShortenWeb.Api.LinkController do
  use ShortenWeb, :controller

  alias Shorten.Links
  alias Shorten.Links.Link

  action_fallback ShortenWeb.FallbackController

  def create(conn, %{"link" => link_params}) do
    # generate a unique slug
    with {:ok, %Link{} = link} <- Links.find_or_create(link_params) do
      conn
      |> put_status(:created)
      |> render("show.json", link: ShortenWeb.Router.Helpers.url(conn) <> "/" <> link.slug)
    end
  end
end
