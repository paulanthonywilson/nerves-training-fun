defmodule Ui.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ui,
      version: "0.0.1",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(Mix.env),
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Ui.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  defp deps do
    [
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      {:device_io, in_umbrella: true},
      {:nerves_cam, in_umbrella: true},
    ]
  end

  def aliases(:prod) do
    [
      "compile": ["compile", "brunch_build", "phx.digest"]
    ]
  end
  def aliases(_), do: []
end
