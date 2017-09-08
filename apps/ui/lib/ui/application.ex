defmodule Ui.Application do
  use Application
  @moduledoc false

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(UiWeb.Endpoint, []),
      worker(UiWeb.SensorChannelBridge, []),
    ]

    opts = [strategy: :one_for_one, name: Ui.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    UiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
