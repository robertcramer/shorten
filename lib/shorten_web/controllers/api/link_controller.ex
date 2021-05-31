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
      |> put_resp_header("location", Routes.link_path(conn, :show, link))
      |> render("show.json", link: link)
    end
  end
end
