defmodule Stack do
  use Application

  def start(_type, args) do
    { :ok, _pid } = Stack.Supervisor.start_link(args)
  end
end
