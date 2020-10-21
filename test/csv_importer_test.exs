defmodule CsvImporterTest do
  use ExUnit.Case, async: true

  test "disconnected and connected render" do
    results = CsvImporter.import_file("../test/fixtures/csvs/valid.csv") |> Enum.at(0)
    assert results == {:ok, %{"first_name" => "Bob", "last_name" => "Jones", "region" => "east"}}
  end
end
