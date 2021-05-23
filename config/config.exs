# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :scouted,
  ecto_repos: [Scouted.Repo]

# Configures the endpoint
config :scouted, ScoutedWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QLFn1hj7MWDp9CJrqz/Y0u8IjBq1mhM6/Hle+f4nOnO64U82uAuAiZQwfPL64IgD",
  render_errors: [view: ScoutedWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Scouted.PubSub,
  live_view: [signing_salt: "RX/i/Sz4"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
