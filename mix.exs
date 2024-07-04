defmodule LibrateUserService.MixProject do
  use Mix.Project

  def project do
    [
      app: :librate_user_service,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.11.3"},
      {:postgrex, "~> 0.18.0"},
      {:flow, "~> 1.2.4"},
      {:broadway_rabbitmq, "~> 0.8.1"},
      {:phoenix_pubsub, "~> 2.1.3"}
      }
    ]
  end
end
