defmodule TickerRing do
  @interval 2000
  @name :ticker

  def start do
    spawn __MODULE__, :ticker, [self]
  end

  def add_client do
    pid = spawn __MODULE__, :receiver, [self]
    register pid
  end

  def ticker(next) do
    :global.register_name @name, self
    receive do
      { :register, new_client } ->
        IO.puts "registering #{inspect new_client}"
        send new_client, { :tick, next }
        receiver(new_client)
    after @interval ->
        IO.puts "tick"
        send next, { :tick }
        receiver(next)
    end
  end

  def receiver(next) do
    receive do
      { :tick, new_client } ->
        IO.puts "tock #{inspect self} to #{inspect new_client}"
        ticker(new_client)
      { :tick } ->
        IO.puts "tock #{inspect self} to #{inspect next}"
        ticker(next)
    end
  end

  def register(pid) do
    send :global.whereis_name(@name), { :register, pid }
  end
end
