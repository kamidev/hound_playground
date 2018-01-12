defmodule HoundPlayground.Mixfile do
  use Mix.Project

  def project do
    [app: :hound_playground,
     version: "0.0.1",
     elixir: "~> 1.6.0-rc.1",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {HoundPlayground, []},
     applications: [:phoenix, :phoenix_pubsub, :phoenix_html, :cowboy, :logger, :gettext]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.3.0"},
    {:phoenix_pubsub, "~> 1.0"},
    {:phoenix_html, "~> 2.10.5"},
    {:phoenix_live_reload, "~> 1.1.3", only: :dev},
    {:gettext, "~> 0.14"},
    {:cowboy, "~> 1.0"},
    # our new dependency
    {:hound, "~> 1.0.4"}]
  end
end
