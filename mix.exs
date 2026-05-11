defmodule Abot.MixProject do
  use Mix.Project

  def project do
    [
      app: :abot,
      version: "0.1.0",
      elixir: "~> 1.19",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Abot.Application, []}
    ]
  end

  defp deps do
    [
      {:nostrum, "~> 0.10"},
      {:httpoison, "~> 2.0"},
      {:jason, "~> 1.4"},
      {:tesla, "~> 1.11"},
    ]
  end
end
