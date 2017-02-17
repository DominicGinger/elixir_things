defmodule MyEnum do
  def split([h|t], amount, res \\ []) do
    if(count(res) < amount) do
      split(t, amount, res ++ [h])
    else
      { res, [h|t] }
    end
  end

  def take([h|t], amount, i \\ 0) do
    if(i < amount) do
      [ h | take(t, amount, i + 1) ]
    else
      []
    end
  end

  defp count([]), do: 0
  defp count([_|t]), do: 1 + count(t)
end