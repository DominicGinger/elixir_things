defmodule EvaluatorTest do
  use ExUnit.Case
  import LineSigil

  test "evaluates a basic expression" do
    input = ~l"""
    1 + 2
    """
    output = ~l"""
    code> 1 + 2
    value> 3
    """

    assert Evaluator.eval(input) == output
  end
end
