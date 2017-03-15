defmodule StackTest do
  use ExUnit.Case

  @initial_stack [1,2,3]

  setup do
    :sys.replace_state(Stack.Server,
                       fn({ _stack, pid }) ->
                         {@initial_stack, pid}
                       end)

    :ok
  end

  test "initial values" do
    { stack, _pid } = :sys.get_state Stack.Server
    assert stack == @initial_stack
  end

  test "pop" do
    assert Stack.Server.pop == Enum.at(@initial_stack, 0)
    assert Stack.Server.pop == Enum.at(@initial_stack, 1)
  end

  test "push" do
    Stack.Server.push 4

    { stack, _pid } = :sys.get_state Stack.Server
    assert stack == [4|@initial_stack]
  end
end
