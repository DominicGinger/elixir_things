defmodule Bang do
  def ok!(n) do
    case n do
      { :ok, x } ->  x
      { :error, err } -> raise "Not okay, error time"
    end
  end
end
