defmodule InformWeb.SendLive do
  use InformWeb, :live_view

  import TwilioService, only: [send_message: 2]

  @impl true

  def mount(_params, _session, socket) do
    IO.puts("Mounting")
    {:ok, assign(socket, query: "", page: 1, recipients: recipients(nil), regions: regions())}
  end

  @impl true
  def handle_event("filter", %{"region" => region}, socket) do
    {:noreply, assign(socket, recipients: recipients(region))}
  end

  @impl true
  def handle_event("message", %{"message" => message}, socket) do
    cond do
      String.length(message) < 10 ->
        {:noreply,
         socket
         |> put_flash(:error, "Message is less than 10 characters")
         |> assign(results: %{})}

      true ->
        {:noreply, clear_flash(socket)}
    end
  end

  def handle_event("back", %{"page" => page}, socket) do
    {:noreply, assign(socket, page: String.to_integer(page))}
  end

  def handle_event("next", %{"page" => page}, socket) do
    {:noreply, assign(socket, page: String.to_integer(page))}
  end

  def handle_event("send", _params, socket) do
    socket.assigns.recipients
    |> Enum.each(fn recipient -> send_message(recipient, socket.assigns.message) end)

    {:noreply, assign(socket, page: 1)}
  end

  defp regions do
    [:east, :west, :south, :triangle, :triad]
  end

  defp recipients(region) do
    all = [
      %{first_name: "Monte", last_name: "Johnston", region: "triangle", phone: "9193331749"},
      %{first_name: "Bob", last_name: "Jones", region: "east"},
      %{first_name: "Artimus", last_name: "Fowle", region: "east"},
      %{first_name: "Oswald", last_name: "Jessup", region: "west"}
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

  @impl true
  def render(assigns) do
    IO.puts("rendering")

    ~L"""
      <div class="row">
    <div  style="display:<%= if @page == 1 do 'block' else 'none' end %>">
      <section class="phx-hero">
        <form phx-change="filter" >
          <label for="region">Region</label>
          <select name="region" id="region-select">
            <option value="">--Please choose an region--</option>
            <%= for region <- @regions do %>
              <option value="<%= region %>"><%= region %></option>
            <% end %>
          </select>
          <button  type="button" phx-click="next" phx-value-page="2" >Next</button>
        </form>
      </section>
      <section class="row">
        <div class="grid">
          <span class="table-header">First Name</span>
          <span class="table-header">Last Name</span>
          <span class="table-header">Region</span>
          <%= for %{first_name: first_name, last_name: last_name, region: region} <- @recipients do %>
            <span ><%= first_name %></span>
            <span ><%= last_name %></span>
            <span ><%= region %></span>
          <% end %>
        </div>
      </section>
    </div>
    <section class="phx-hero" style="display:<%= if @page == 2 do 'block' else 'none' end %>">
      <p>This message will go to <%= length(@recipients) %> recipients</p>
      <form  phx-change="message" phx-submit="send">
      <label for="message">Message</label>
      <textarea name="message" autofocus /></textarea>

      <button phx-click="back" phx-value-page="1" type="button" >Back</button>
      <button type="submit" phx-disable-with="Searching...">Next</button>
      </form>
    </section>
    """
  end
end
