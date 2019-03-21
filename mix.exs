defmodule DatsiBot.MixProject do
  use Mix.Project

  def project do
    [
      app: :datsi_bot,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {DatsiBot.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:floki, "~> 0.20.0"},
      {:html5ever, "~> 0.7.0"},
      {:tesla, "~> 1.2.1"},
      {:ex_gram, "~> 0.6"},
      {:jason, "~> 1.1"},
      {:redix, ">= 0.0.0"}
    ]
  end
end
