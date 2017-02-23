defmodule Capital do
  def capitalize(str) do
    str
    |> String.split(". ")
    |> Enum.map(&(String.capitalize(&1)))
    |> Enum.join(". ")
  end
end
