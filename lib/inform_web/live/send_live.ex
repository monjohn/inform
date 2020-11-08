defmodule InformWeb.SendLive do
  use InformWeb, :live_view

  import TwilioService, only: [send_message: 2]

  @impl true

  def mount(_params, _session, socket) do
    IO.puts("Mounting")

    {:ok,
     assign(socket,
       query: "",
       page: 1,
       recipients: Inform.Accounts.list_users(),
       regions: [:all | Ecto.Enum.values(Inform.Accounts.User, :region)],
       selected_region: :all
     )}
  end

  @impl true
  def handle_event("filter", %{"region" => region}, socket) do
    recipients = Inform.Accounts.list_users(region: region)
    {:noreply, assign(socket, recipients: recipients)}
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

  def handle_event("send", %{"message" => message}, socket) do
    socket.assigns.recipients
    |> Enum.each(fn recipient -> send_message(recipient, message) |> IO.inspect() end)

    {:noreply,
     push_redirect(socket,
       to: Routes.recipients_path(socket, :index)
     )}
  end
end
