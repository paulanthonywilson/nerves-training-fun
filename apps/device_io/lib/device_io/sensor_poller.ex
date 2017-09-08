defmodule DeviceIO.SensorPoller do
  @moduledoc """
  Polls the sensor every second and broadcasts the events using `DeviceIO.SensorReading`
  """

  alias DeviceIO.{SensorReading, Barometer}

  use GenServer

  @name __MODULE__
  @poll_millis 1_000

  def start_link() do
    GenServer.start_link(__MODULE__, {}, name: @name)
  end

  def init(_) do
    send(self(), :enable_barometer)
    Process.send_after(self(), :poll, @poll_millis)
    {:ok, {}}
  end

  def handle_info(:enable_barometer, s) do
    Barometer.enable()
    {:noreply, s}
  end

  def handle_info(:poll, s) do
    %{
      temperature: temperature,
      pressure: pressure,
      altitude: height,
    } = Barometer.measure_all()

    reading = %SensorReading{
      temperature: temperature,
      pressure: pressure,
      height: height,
      light_level: 0.0,
      time: DateTime.utc_now()
    }

    SensorReading.broadcast(reading)
    Process.send_after(self(), :poll, @poll_millis)
    {:noreply, s}
  end
end
