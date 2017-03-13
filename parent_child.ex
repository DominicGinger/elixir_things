defmodule ParentChild do

  def child(parent) do
    send parent, "MSG"
    exit(:hello)
  end

  def parent do
    Process.flag(:trap_exit, true)
    spawn_link(ParentChild, :child, [self])
    :timer.sleep 500
    receive_msg
  end

  def receive_msg do
    receive do
      msg ->
        IO.puts "MESSAGE: #{inspect msg}"
        receive_msg
    after 500 ->
        IO.puts "END"
    end
  end
end
