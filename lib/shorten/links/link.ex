defmodule Shorten.Links.Link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :slug, :string
    field :url, :string

    timestamps()
  end

  def changeset(link, attrs) do
    link
    |> cast(attrs, [:url])
    |> put_change(:slug, generate_slug(8))
    |> validate_required([:slug, :url])
    |> validate_url()
    |> unique_constraint(:slug)
    |> unique_constraint(:url)
  end

  defp generate_slug(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end

  defp validate_url(changeset) do
    url = get_field(changeset, :url)
    case EctoFields.URL.cast(url) do
      {:ok, _url} ->
        changeset
      :error ->
        add_error(changeset, :url, "invalid url")
    end
  end
end
