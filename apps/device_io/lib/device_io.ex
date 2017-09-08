defmodule DeviceIO do
  @moduledoc """
  Interface for Device IO. Enable subscribing to IO events 0
  """

  @doc """
  Subscribe the current process.

  Messages received will be of the form `{:device_io_sensor_event, event}`
  """
  @spec subscribe() ::  {:error, {:already_registered, pid}} | {:ok, pid}
  def subscribe() do
    DeviceIO.SensorReading.subscribe()
  end
end
