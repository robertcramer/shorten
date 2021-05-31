defmodule ShortenWeb.Api.LinkView do
  use ShortenWeb, :view

  def render("show.json", %{link: link}) do
    %{shortLink: link}
  end
end
