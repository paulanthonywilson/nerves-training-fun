defmodule DeviceIo.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(ElixirALE.I2C, ["i2c-1", 0x77, [name: Barometer.I2C]]),
      supervisor(Registry, [:duplicate,  :device_io_events_registry]),
      worker(DeviceIO.SensorPoller, []),
    ]

    opts = [strategy: :one_for_one, name: DeviceIo.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
