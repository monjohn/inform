defmodule InformWeb.RecipientsLive do
  use InformWeb, :live_view

  import Inform.Recipients, only: [recipients: 1]

  @impl true
  def mount(_params, _session, socket) do
    IO.puts("Mounting")

    {:ok,
     assign(socket,
       recipients: recipients(nil),
       current: nil,
       messages: TwilioService.test_messages()
     )}
  end

  @impl true

  def handle_event("select", %{"id" => id}, socket) do
    id = String.to_integer(id)
    messages = TwilioService.all_messages()
    {:noreply, assign(socket, messages: messages)}
  end

end
