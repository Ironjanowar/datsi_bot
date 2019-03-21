defmodule DatsiBot do
  use Tesla

  require Logger

  @base_url "https://www.datsi.fi.upm.es/docencia"

  plug(Tesla.Middleware.BaseUrl, @base_url)

  defp get_href_url(properties, subject) do
    case Enum.find(properties, fn property -> elem(property, 0) == "href" end) do
      {_, "./" <> href} -> @base_url <> subject <> href
      {_, href} -> @base_url <> subject <> href
      _ -> ""
    end
  end

  defp get_new(new, subject) do
    [date | rest] =
      Enum.map(new, fn item ->
        case item do
          {"a", properties, text} ->
            link = get_href_url(properties, subject)
            link_text = Enum.join(text, " ")
            "[#{link_text}](#{link})"

          {_, _, text} ->
            text |> Enum.map(&String.trim/1) |> Enum.join(" ")

          text ->
            text |> String.trim()
        end
      end)

    rest =
      rest
      |> Enum.map(&String.replace(&1, "\n", " "))
      |> Enum.join(" ")
      |> String.split(" .")
      |> Enum.map(&String.trim/1)
      |> Enum.join(". ")

    "*#{date}*\n#{rest}"
  end

  def get_news() do
    subject = "/Arquitectura_09/"
    {:ok, %{body: body}} = get(subject)

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
    |> Enum.map(fn {"li", _, childs} -> get_new(childs, subject) end)
  end
end
