defmodule CsvImporter do
  require Logger

  def import_file(filename) do
    filename
    |> Path.expand(__DIR__)
    |> File.stream!()
    |> CSV.decode(headers: true)
    |> Stream.filter(&process_row/1)
  end

  def process_row(parsed) do
    case parsed do
      {:ok, map} ->
        map

      {:error, error} ->
        Logger.error(error)
        false
    end
  end
end
