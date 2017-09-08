defmodule UiWeb.SensorChannel do
  @moduledoc """
  Channel to join.
  """

  use UiWeb, :channel

  def join("sensor", _payload, socket) do
    {:ok, socket}
  end
end
