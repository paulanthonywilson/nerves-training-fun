defmodule DeviceIO.SensorReading do
  @moduledoc """
  Enables a process to subscribe to sensor update events and broadcasting those events
  to the subscribers.
  """

  @type celsius :: integer
  @type pascals :: float
  @type metres :: float


  @enforce_keys [:temperature, :pressure, :height, :light_level, :time]
  defstruct temperature: nil, pressure: nil, height: nil, light_level: nil, time: nil
  @type t :: %__MODULE__{temperature: celsius, pressure: pascals, height: metres, light_level: integer, time: DateTime.t}

  @topic :sensor_event
  @registry :device_io_events_registry

  @doc """
  Subscribe the current process.

  Messages received will be of the form `{:device_io_sensor_event, event}`
  """
  @spec subscribe() ::  {:error, {:already_registered, pid}} | {:ok, pid}
  def subscribe() do
    Registry.register(@registry, @topic, [])
  end

  @doc """
  Broadcast an event to the topic. The topic receives
  {:battle_event, topic, event}
  """
  @spec broadcast(__MODULE__.t) :: :ok
  def broadcast(event = %__MODULE__{}) do
    Registry.dispatch(@registry, @topic, fn entries ->
      for {pid, _} <- entries, do: send(pid, {:device_io_sensor_event, event})
    end)
  end
end
