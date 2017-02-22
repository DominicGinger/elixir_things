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

  def all?([], _), do: true
  def all?([h|t], func) do
    if func.(h) do
      all?(t, func)
    else
      false
    end
  end

  def each(_, _, res \\ [])
  def each([], _, res), do: res
  def each([h|t], func, res) do
    each(t, func, res ++ [func.(h)])
  end

  def filter([], _), do: []
  def filter([h|t], func) do
    if func.(h) do
      [h] ++ filter(t, func)
    else
      filter(t, func)
    end
  end

  defp count([]), do: 0
  defp count([_|t]), do: 1 + count(t)
end
