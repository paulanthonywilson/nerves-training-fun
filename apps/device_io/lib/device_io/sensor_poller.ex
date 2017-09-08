defmodule DeviceIO.SensorPoller do
  @moduledoc """
  Polls the sensor every second and broadcasts the events using `DeviceIO.SensorReading`
  """

  alias DeviceIO.SensorReading

  use GenServer

  @name __MODULE__
  @poll_millis 1_000

  def start_link() do
    GenServer.start_link(__MODULE__, {}, name: @name)
  end

  def init(_) do
    Process.send_after(self(), :poll, @poll_millis)
    {:ok, {}}
  end

  def handle_info(:poll, s) do
    reading = %SensorReading{
      temperature: :rand.uniform(100),
      pressure: 0.0,
      height: 0.0,
      light_level: 0.0,
      time: DateTime.utc_now()
    }

    SensorReading.broadcast(reading)
    Process.send_after(self(), :poll, @poll_millis)
    {:noreply, s}
  end


end
