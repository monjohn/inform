defmodule TwilioService do
  require Logger

  @organization_number "16508259321"

  def send_trial_message do
    {target_number, body} = {"+19193331749", "Hello World"}
    ExTwilio.Message.create(to: target_number, from: @organization_number, body: body)
  end

  def all_messages do
    ExTwilio.Message.all()
  end

  def send_message(%{phone: to_number}, message) do
    ExTwilio.Message.create(to: to_number, from: @organization_number, body: message)
  end

  def send_message(%{first_name: first_name, last_name: last_name}, message) do
    Logger.error("No phone number for #{first_name} #{last_name} to send message: #{message}")
  end

  # ExTwilio.Message.find("SM67192f2112534784b89f450495f27f5d")
  # {:ok,
  #  %ExTwilio.Message{
  #    account_sid: "AC25b06f206bcb9576c2b90584cba42bb3",
  #    api_version: "2010-04-01",
  #    body: "Sent from your Twilio trial account - Hello World",
  #    date_created: "Sun, 18 Oct 2020 15:33:51 +0000",
  #    date_sent: "Sun, 18 Oct 2020 15:33:51 +0000",
  #    date_updated: "Sun, 18 Oct 2020 15:33:52 +0000",
  #    direction: "outbound-api",
  #    error_code: nil,
  #    error_message: nil,
  #    from: "+16508259321",
  #    messaging_service_sid: nil,
  #    num_media: "0",
  #    num_segments: "1",
  #    price: "-0.00750",
  #    price_unit: "USD",
  #    sid: "SM67192f2112534784b89f450495f27f5d",
  #    status: "delivered",
  #    subresource_uri: nil,
  #    to: "+19193331749",
  #    uri: "/2010-04-01/Accounts/AC25b06f206bcb9576c2b90584cba42bb3/Messages/SM67192f2112534784b89f450495f27f5d.json"
  #  }}
end
