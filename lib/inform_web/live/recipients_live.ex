defmodule InformWeb.RecipientsLive do
  use InformWeb, :live_view
  alias Inform.Accounts

  @impl true
  def mount(_params, _session, socket) do
    IO.puts("Mounting")

    {:ok,
     assign(socket,
       recipients: Accounts.list_users(),
       current: nil,
       messages: []
     )}
  end

  def format_date(date_str) do
    case Calendar.DateTime.Parse.rfc2822_utc(date_str) do
      {:ok, date_time} ->
        Calendar.DateTime.shift_zone!(date_time, "America/New_York")
        |> Calendar.Strftime.strftime!("%a, %b %e, %Y %l:%M %P")

      {:error, error} ->
        error
    end
  end

  @impl true
  def handle_event("select", %{"phone" => phone}, socket) do
    messages = TwilioService.messages_for(%{phone: phone})
    {:noreply, assign(socket, messages: messages)}
  end

  def handle_event("filter", %{"namesearch" => name}, socket) do
    recipients = Inform.Accounts.users_like(name)
    {:noreply, assign(socket, recipients: recipients)}
  end
end
