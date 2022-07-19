defmodule Core.MixProject do
  use Mix.Project

  def project do
    [
      app: :convex,
      version: "0.1.0",
      elixir: "~> 1.13.3",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Core.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["app", "test/support"]
  defp elixirc_paths(_), do: ["app"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:absinthe_plug, "~> 1.5", override: true},
      {:phoenix_live_dashboard, "~> 0.6"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:phoenix_ecto, "~> 4.4"},
      {:plug_cowboy, "~> 2.5"},
      {:phoenix, "~> 1.6.11"},
      {:absinthe, "~> 1.6.0"},
      {:postgrex, ">= 0.0.0"},
      {:number, "~> 1.0.1"},
      {:ecto_sql, "~> 3.6"},
      {:gettext, "~> 0.18"},
      {:swoosh, "~> 1.3"},
      {:tesla, "~> 1.4"},
      {:jason, "~> 1.2"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup", "ecto.migrate"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
