defmodule Emissionrest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      EmissionrestWeb.Telemetry,
      Emissionrest.Repo,
      {Ecto.Migrator,
        repos: Application.fetch_env!(:emissionrest, :ecto_repos),
        skip: skip_migrations?()},
      {DNSCluster, query: Application.get_env(:emissionrest, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Emissionrest.PubSub},
      # Start a worker by calling: Emissionrest.Worker.start_link(arg)
      # {Emissionrest.Worker, arg},
      # Start to serve requests, typically the last entry
      EmissionrestWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Emissionrest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EmissionrestWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp skip_migrations?() do
    # By default, sqlite migrations are run when using a release
    System.get_env("RELEASE_NAME") != nil
  end
end
