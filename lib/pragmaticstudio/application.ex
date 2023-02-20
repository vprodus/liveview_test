defmodule Pragmaticstudio.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PragmaticstudioWeb.Telemetry,
      # Start the Ecto repository
      Pragmaticstudio.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Pragmaticstudio.PubSub},
      # Start Finch
      {Finch, name: Pragmaticstudio.Finch},
      # Start the Endpoint (http/https)
      PragmaticstudioWeb.Endpoint
      # Start a worker by calling: Pragmaticstudio.Worker.start_link(arg)
      # {Pragmaticstudio.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pragmaticstudio.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PragmaticstudioWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
