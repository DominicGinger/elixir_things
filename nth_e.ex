defmodule NthE do
    def calc(limit) do
        :math.pow(1/limit + 1, limit)
    end
end

IO.puts NthE.calc(100000)