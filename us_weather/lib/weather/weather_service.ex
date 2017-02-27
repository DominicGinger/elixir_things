defmodule UsWeather.WeatherService do

  require Logger

  @user_agent [ { "User-agent", "Elixir user@example.com" } ]
  @weather_url Application.get_env(:us_weather, :weather_url)

  def fetch(area_code) do
    Logger.info "Fetching for #{area_code}"
    full_url(area_code)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def full_url(area_code) do
    "#{@weather_url}#{area_code}.xml"
  end

  def handle_response({ :ok, %{ status_code: 200, body: body }}) do
    Logger.info "Successful response"
    Logger.debug fn -> inspect(body) end
    { :ok, body }
  end

  def handle_response({ _, %{ status_code: status, body: body }}) do
    Logger.error "Error #{status} returned"
    { :error, body }
  end
end
