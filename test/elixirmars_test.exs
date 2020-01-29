defmodule ElixirmarsTest do
  use ExUnit.Case
  doctest Elixirmars

  test "greets the world" do
    assert Elixirmars.hello() == :world
  end
end
