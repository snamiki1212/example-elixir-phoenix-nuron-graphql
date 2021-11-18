defmodule Gh.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Gh.Repo,
      # Start the Telemetry supervisor
      GhWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Gh.PubSub},
      # Start the Endpoint (http/https)
      GhWeb.Endpoint
      # Start a worker by calling: Gh.Worker.start_link(arg)
      # {Gh.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gh.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GhWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
