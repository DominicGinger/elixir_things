defmodule CsvReader do
  def read(file_name) do
    { :ok, file } = File.open(file_name)
    headers = IO.read(file, :line)
              |> get_line
              |> Enum.map(&(String.to_atom(&1)))

    IO.stream(file, :line)
    |> Enum.map(&(get_row(&1, headers)))
  end

  defp zip(line, headers), do: Enum.zip(headers, line)

  defp get_row(line, headers) do
    get_line(line)
    |> set_types
    |> zip(headers)
  end

  defp get_line(line) do
    String.strip(line, ?\n)
    |> String.split(",")
  end

  defp set_types(line) do
    [a, b, c] = line
    [ String.to_integer(a),
      String.to_atom(b),
      String.to_float(c) ]
  end
end
