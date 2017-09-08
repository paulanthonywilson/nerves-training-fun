defmodule DeviceIO.SensorReadingTest do
  use ExUnit.Case

  alias DeviceIO.SensorReading

  setup do
    SensorReading.subscribe()
    :ok
  end

  test "receving events" do
    reading = %SensorReading{temperature: 1.0, pressure: 2000, height: 125.2, light_level: 27, time: DateTime.utc_now}
    SensorReading.broadcast(reading)

    assert_receive {:device_io_sensor_event, ^reading}
  end
end
