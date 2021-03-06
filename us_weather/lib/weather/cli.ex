defmodule UsWeather.CLI do

  def main(argv) do
    argv
    |> parse_args
    |> fetch
    |> parse
  end

  defp parse(xml) do
    { doc, _ } = xml |> :binary.bin_to_list |> :xmerl_scan.string
    doc
  end

  defp fetch(:help) do
    IO.puts """
    usage: issues <user> <project> [ count | #{@default_count} ]
    """
    System.halt(0)
  end

  defp fetch({ area_code }) do
    { :ok, data } = UsWeather.WeatherService.fetch(area_code)
    data
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
