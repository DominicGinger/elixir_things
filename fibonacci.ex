defmodule Fibon do
    def fib(x), do: fib(0, 1, x)
    defp fib(a, _, 0), do: a
    defp fib(a, b, n), do: fib(b, a+b, n-1)
end

IO.puts Fibon.fib(100000)
