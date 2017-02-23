defmodule StringCalc do
    def calc(input) do
        [operation|numbers] = scan(input)
        |> Enum.reverse

        [[second]|first] = numbers
        {a, _} = :string.to_integer(Enum.reverse(first))
        {b, _} = :string.to_integer(second)
        case operation do
            :+ -> a + b
            :- -> a - b
            :* -> a * b
            :/ -> a / b
        end
    end

    def scan([]), do: []
    def scan([h|t]) do
        case h do
            42 -> [[scan(t)], :*]
            43 -> [[scan(t)], :+]
            45 -> [[scan(t)], :-]
            47 -> [[scan(t)], :/]
            32 -> scan(t)
            _ -> [h|scan(t)]
        end
    end
end