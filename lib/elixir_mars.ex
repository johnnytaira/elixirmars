defmodule ElixirMars do
  @moduledoc """
  Módulo de pouso da NASA.

  """


  @doc """
  Gera o mapa com a rota das sondas a partir de um arquivo.
  """
  def get_map_route(route_file) do
    FileManager.read(route_file)
  end

  @doc """
  Executa todos os passos para controlar as sondas no planeta Marte. As coordenadas de cada sonda são definidas no arquivo in.txt.
  ## Example
        iex> ElixirMars.run()
        iex> :ok
  """
  def run do
    get_map_route("in.txt")
    |> navigate()
    |> FileManager.save("out.txt")
  end

  @doc """
  Navega uma lista de sondas pelo planeta Marte.

  Retorna uma lista, cada item contém um mapa com a posição (X, Y) e também a direção Z da sonda.
  ## Example
        iex> ElixirMars.navigate(
        ...> %{
        ...>   "coordinates" => [["1 2 N", "LMLMLMLMM"], ["3 3 E", "MMRMMRMRRM"]],
        ...>   "field_size" => "5 5"
        ...>  })


        iex> [%{x: 1, y: 3, z: "N"}, %{x: 5, y: 1, z: "E"}]
  """
  def navigate(route) do
    Enum.map(
      route
      |> Map.get("coordinates"),
      fn coordinate ->
        define_landing_point(List.first(coordinate), List.last(coordinate))
      end
    )
  end

  #Maquina de estados da Sonda. A chave é a direção atual, o valor é a direção que irá virar.
  @left %{"N" => "W", "W" => "S", "S" => "E", "E" => "N"}
  @right %{"N" => "E", "E" => "S", "S" => "W", "W" => "N"}

  defp define_landing_point(starting_position, actions) do
    [row, column, direction] = String.split(starting_position, " ")

    String.split(actions, "")
    |> List.delete("")
    |> List.delete("")
    |> Enum.reduce(
      %{
        x: String.to_integer(row),
        y: String.to_integer(column),
        z: direction
      },
      fn action, acc ->
        case action do
          "L" -> Map.put(acc, :z, Map.get(@left, acc[:z]))
          "R" -> Map.put(acc, :z, Map.get(@right, acc[:z]))
          "M" -> move(acc)
        end
      end
    )
  end

  defp move(%{z: direction} = acc)
    when direction ==  "N"
  do
    Map.put(acc, :y, acc[:y] + 1)
  end

  defp move(%{z: direction} = acc)
    when direction ==  "S"
  do
    Map.put(acc, :y, acc[:y] - 1)
  end

  defp move(%{z: direction} = acc)
    when direction ==  "E"
  do
    Map.put(acc, :x, acc[:x] + 1)
  end

  defp move(%{z: direction} = acc)
    when direction ==  "W"
  do
    Map.put(acc, :x, acc[:x] - 1)
  end
end
