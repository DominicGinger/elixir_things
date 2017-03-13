defmodule ParentChildMonitor do

  def child(parent) do
    send parent, "MSG"
    raise parent, "ERROR"
    exit(:hello)
  end

  def parent do
    Process.flag(:trap_exit, true)
    spawn_monitor(ParentChildMonitor, :child, [self])
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
