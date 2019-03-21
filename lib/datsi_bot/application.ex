defmodule DatsiBot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  def start(_type, _args) do
    token = ExGram.Config.get(:ex_gram, :token)

    children = [
      ExGram,
      {DatsiBot.Bot, [method: :polling, token: token]},
      {Redix, [host: "localhost", port: 6379, name: :redix]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DatsiBot.Supervisor]
    Logger.info("DatsiBot started")
    Supervisor.start_link(children, opts)
  end
end
