defmodule DatsiBot do
  use Tesla

  require Logger

  plug(Tesla.Middleware.BaseUrl, "https://www.datsi.fi.upm.es/docencia")

  def get_news() do
    {:ok, %{body: body}} = get("/Arquitectura_09/")

    [{"ul", _attributes, news} | _] =
      body
      |> :binary.bin_to_list()
      |> to_string
      |> Floki.parse()
      |> Floki.find(".noticias")
      |> Floki.find("ul")

    news
    |> Enum.filter(fn li ->
      case li do
        {"li", _, _} -> true
        _ -> false
      end
    end)
    |> Enum.map(fn li ->
      li
      |> Floki.find("b")
      |> Enum.map(&Floki.text/1)
    end)
    |> Enum.map(fn [date | rest] ->
      rest = Enum.map(rest, fn t -> String.replace(t, "\n", " ") end)
      "*#{date}*\n#{Enum.join(rest, " ")}"
    end)
  end
end
