defmodule FileManager do
  def read(filename) do
    case File.read(filename) do
      {:ok, input} -> extract(input)
      {:error, _} -> {:error, "Can't read the file!!"}
    end
  end

  def save(result, filename) do
    File.write(
      filename,
      Enum.map(
        result,
        fn x ->
          Map.values(x) |> Enum.join(" ") |> String.pad_trailing(6, "\n")
        end
      )
      |> List.to_string()

    )

    # binary = :erlang.term_to_binary(result)
    # File.write(filename, binary)
  end

  defp extract(input) do
    Map.put(
      %{},
      "coordinates",
      String.split(input, "\n")
      |> Enum.slice(1, length(String.split(input, "\n")))
      |> List.flatten()
      |> Enum.chunk_every(2)
    )
    |> Map.put(
      "field_size",
      String.split(input, "\n")
      |> List.first()
    )
  end
end
