defmodule DatsiBotTest do
  use ExUnit.Case
  doctest DatsiBot

  test "greets the world" do
    assert DatsiBot.hello() == :world
  end
end
