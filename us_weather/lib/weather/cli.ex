defmodule UsWeather.CLI do

  def main(argv) do
    argv
    |> parse_args
    |> fetch
  end

  defp fetch(:help) do
    IO.puts """
    usage: issues <user> <project> [ count | #{@default_count} ]
    """
    System.halt(0)
  end

  defp fetch({ area_code }) do
    UsWeather.WeatherService.fetch(area_code)
  end

  defp parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean ],
                               aliases: [ h: :help ])
    case parse do
      { [ help: true ], _, _ } ->
        :help
      { _, [ area_code ], _ } ->
        { area_code }

      _ -> :help
    end
  end
end
