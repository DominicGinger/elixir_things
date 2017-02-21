defmodule MyList do
  def span(from, to) when from > to, do: []
  def span(from, to), do: [from|span(from+1, to)]

  def flatten(_, res \\ [])
  def flatten([], res), do: res
  def flatten([h|t], res) when is_list(h) do
    flatten(h, res) ++ flatten(t, [])
  end
  def flatten([h|t], res), do: flatten(t, res ++ [h])
end
