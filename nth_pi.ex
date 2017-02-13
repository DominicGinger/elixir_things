defmodule NthPi do

  def calc(limit) do
    loop(0, 1, odd(limit), 0)
  end

  defp odd(number) do
    if rem(number, 2) == 0, do: number+1, else: number
  end

  defp loop(res, limit, limit, _) do
    res
  end
  
  defp loop(res, n, limit, count) do
    sign = if rem(count, 2) == 0, do: 1, else: -1
    loop(res+(sign*(4/n)), n+2, limit, count+1)
  end
end

IO.puts NthPi.calc(50000)