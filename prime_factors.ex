defmodule PrimeFactors do
  def calc(num) do
    factors(num, div(num, 2))
    |> Stream.filter(&(prime?(&1, div(&1, 2))))
    |> Enum.to_list
  end

  defp factors(_, 1), do: [1]
  defp factors(num, d) when rem(num, d) == 0 do
    [d|factors(num, d-1)]
  end
  defp factors(num, d) do
    factors(num, d-1)
  end

  defp prime?(_, 1), do: true
  defp prime?(1, _), do: true
  defp prime?(num, check) when rem(num, check) == 0 do
    false
  end
  defp prime?(num, check) do
    prime?(num, check-1)
  end
end