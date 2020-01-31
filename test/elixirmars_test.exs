defmodule ElixirMarsTest do
  use ExUnit.Case
  doctest ElixirMars

  def map_fixture(path) do
    ElixirMars.get_map_route(path)
  end
  test "navigate successfully" do
    route = map_fixture("test/sample.txt")
    assert [%{
      x: 0,
      y: 2,
      z: "W"
    }] = ElixirMars.navigate(route)
  end

  test "navigate fail" do
    route = map_fixture("test/sample.txt")
    assert [%{
      x: 0,
      y: 2,
      z: "E"
    }] != ElixirMars.navigate(route)
  end

  test "get route with wrong file name fails" do
    assert {:error, _} = ElixirMars.get_map_route("test/wrong.txt")

  end

  test "get route successfully" do
    assert %{
      "coordinates" => [["1 2 N", "LM"]],
      "field_size" => "5 5"
    } = ElixirMars.get_map_route("test/sample.txt")

  end

end
