defmodule Inform.Recipients do
  def recipients(region) do
    all = [
      %{
        id: 1,
        first_name: "Monte",
        last_name: "Johnston",
        region: "triangle",
        phone: "9193331749"
      },
      %{id: 2, first_name: "Bob", last_name: "Jones", region: "east", phone: "number"},
      %{id: 3, first_name: "Artimus", last_name: "Fowle", region: "east", phone: "number"},
      %{id: 4, first_name: "Oswald", last_name: "Jessup", region: "west", phone: "number"},
      %{
        id: 5,
        first_name: "Kari",
        last_name: "Johnston",
        region: "triad",
        phone: "2524025050"
      }
    ]

    case region do
      nil ->
        all

      _region ->
        Enum.filter(all, fn %{region: recip_region} ->
          region == recip_region
        end)
    end
  end

  def regions do
    [:east, :west, :south, :triangle, :triad]
  end
end
