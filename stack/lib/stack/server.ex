defmodule Stack.Server do
  use GenServer

  @vsn "0"

  def start_link(stash_pid) do
    GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def pop do
    GenServer.call __MODULE__, :pop
  end

  def push(item) do
    GenServer.cast __MODULE__, { :push, item }
  end

  # GenServer

  def init(stash_pid) do
    current_stack = Stack.Stash.get_value stash_pid
    { :ok, { current_stack, stash_pid } }
  end

  def handle_call(:pop, _from, { [head|tail], stash_pid }) do
    { :reply, head, { tail, stash_pid } }
  end

  def handle_cast({ :push, item }, { stack, stash_pid }) do
    { :noreply, { [item|stack], stash_pid } }
  end

  def terminate(_reason, { current_stack, stash_pid }) do
    Stack.Stash.save_value stash_pid, current_stack
  end
end

