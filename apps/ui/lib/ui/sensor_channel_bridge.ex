defmodule UiWeb.SensorChannelBridge do
  @moduledoc """
  Listens for update commands and broadcasts to the channel
  """

  @topic "sensor"
  @name __MODULE__

  def start_link do
    GenServer.start_link(__MODULE__, {}, name: @name)
  end

  def init(_) do
    DeviceIO.subscribe()
    {:ok, {}}
  end

  def handle_info({:device_io_sensor_event, event}, s) do
    UiWeb.Endpoint.broadcast(@topic, "device_io_sensor_event", event)
    {:noreply, s}
  end
end
