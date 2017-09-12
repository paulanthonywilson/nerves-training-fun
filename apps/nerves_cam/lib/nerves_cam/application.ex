defmodule NervesCam.Application do
  @moduledoc false

  use Application
  import Supervisor.Spec, warn: false

  def start(_type, _args) do
    children = [
    ]

    opts = [strategy: :one_for_one, name: NervesCam.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
