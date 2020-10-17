defmodule Inform.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Inform.Repo,
      # Start the Telemetry supervisor
      InformWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Inform.PubSub},
      # Start the Endpoint (http/https)
      InformWeb.Endpoint
      # Start a worker by calling: Inform.Worker.start_link(arg)
      # {Inform.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Inform.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    InformWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
