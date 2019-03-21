defmodule DatsiBot.Redis do
  def get_sent_news(id) do
    Redix.command(:redix, ["SMEMBERS", id])
  end

  def set_sent_news(id, news) do
    Enum.each(news, &Redix.command(:redix, ["SADD", id, &1]))
  end
end
