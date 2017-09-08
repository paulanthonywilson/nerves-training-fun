defmodule DeviceIoTest do
  use ExUnit.Case
  doctest DeviceIo

  test "greets the world" do
    assert DeviceIo.hello() == :world
  end
end
