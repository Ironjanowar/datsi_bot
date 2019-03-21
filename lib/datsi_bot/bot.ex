defmodule DatsiBot.Bot do
  @bot :datsi_bot
  use ExGram.Bot, name: @bot

  def bot(), do: @bot

  def handle({:command, "start", _msg}, context) do
    answer(context, "Hi!")
  end

  def handle({:command, "news", %{chat: %{id: cid}} = _msg}, _context) do
    DatsiBot.get_news()
    |> Enum.map(
      &ExGram.send_message(cid, &1, parse_mode: "Markdown", disable_web_page_preview: true)
    )
  end
end
