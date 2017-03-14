defmodule Scheduler do
  def run(num_processes, module, func, to_calculate, args) do
    (1..num_processes)
    |> Enum.map(fn(_) -> spawn(module, func, [self]) end)
    |> schedule_processes(to_calculate, [], args)
  end

  defp schedule_processes(processes, queue, results, args) do
    receive do
      { :ready, pid } when length(queue) > 0 ->
        [ next | tail ] = queue
        send pid, { :find_word, next, self, args }
        schedule_processes(processes, tail, results, args)

      { :ready, pid } ->
        send pid, { :shutdown }
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results, args)
        else
          Enum.sort(results, fn { n1, _ }, { n2, _ } -> n1 <= n2 end)
        end

      { :answer, file_name, result, _pid } ->
        schedule_processes(processes, queue, [ {file_name, result}| results], args)
    end
  end
end

defmodule WordFinder do
  def find_word(scheduler) do
    send scheduler, { :ready, self }
    receive do
      { :find_word, file_name, client, %{ search_term: search_term } } ->
        count = File.read!(file_name)
        |> String.split(search_term)
        |> length
        |> - 1
        send client, { :answer, file_name, count, self }
        find_word(scheduler)
      { :shutdown } ->
        exit(:normal)
    end
  end
end

file_names = File.ls!(".") |>
Enum.filter(fn(x) -> List.last(String.split(x,".")) == "ex" end)

Enum.each 1..length(file_names), fn num_processes ->
  {time, result} = :timer.tc(
                             Scheduler, :run,
                             [num_processes, WordFinder, :find_word, file_names, %{ search_term: "def" }]
                           )
    if num_processes == 1 do
      IO.puts inspect result
      IO.puts "\n # time (s)"
    end
    :io.format "~2B  ~.7f~n", [num_processes, time/1000000.0]
end
