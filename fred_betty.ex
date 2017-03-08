defmodule FredBetty do

  def mirror do
    receive do
      { sender, msg } ->
        send sender, { :ok, msg }
    end
  end

  def run do
    spawn_process("Fred")
    spawn_process("Betty")

    listen(0)
  end

  defp spawn_process(msg) do
    send spawn(FredBetty, :mirror, []), { self(), msg }
  end

  defp listen(count) do
    receive do
      { :ok, msg } ->
        IO.puts msg
        if(count < 1) do
          listen(count + 1)
        end
    end
  end
end
