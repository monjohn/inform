# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :inform,
  ecto_repos: [Inform.Repo]

# Configures the endpoint
config :inform, InformWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "6aIWChR4HUuQNKnYBbKP0BVka9A8en4Z/7RUpWPZMj3j59+j91eozbbJ7kMMfnB3",
  render_errors: [view: InformWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Inform.PubSub,
  live_view: [signing_salt: "z+olHh1T"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ex_twilio,
  account_sid: {:system, "TWILIO_ACCOUNT_SID"},
  auth_token: {:system, "TWILIO_AUTH_TOKEN"}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
