defmodule InformWeb.PageLive do
  use InformWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: "", results: %{}, recipients: [], regions: regions())}
  end

  @impl true
  def handle_event("filter", %{"region" => region}, socket) do
    {:noreply, assign(socket, recipients: recipients(region))}
  end

  @impl true
  def handle_event("submit", %{"region" => region}, socket) do
    case region do
      "west" ->
        {:noreply, redirect(socket, external: "region")}

      _ ->
        {:noreply,
         socket
         |> put_flash(:error, "No dependencies found matching \"#{region}\"")
         |> assign(results: %{}, region: nil)}
    end
  end

  defp regions do
    [:east, :west, :south, :triangle, :triad]
  end

  defp recipients(region) do
    all = [
      %{first_name: "Bob", last_name: "Jones", region: "east"},
      %{first_name: "Artimus", last_name: "Fowle", region: "east"},
      %{first_name: "Oswald", last_name: "Jessup", region: "west"}
    ]

    case region do
      nil ->
        all

      _region ->
        Enum.filter(all, fn %{region: recip_region} ->
          IO.puts(region)
          region == recip_region
        end)
    end
  end
end
