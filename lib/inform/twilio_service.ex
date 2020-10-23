defmodule TwilioService do
  require Logger

  @organization_number "16508259321"

  def phone_number do
    @organization_number
  end

  def send_trial_message do
    {target_number, body} = {"+19193331749", "Hello World"}
    ExTwilio.Message.create(to: target_number, from: @organization_number, body: body)
  end

  def all_messages do
    messages = ExTwilio.Message.all()
    IO.inspect(messages)
    messages
  end

  def test_messages do
    [
      %ExTwilio.Message{
        account_sid: "AC25b06f206bcb9576c2b90584cba42bb3",
        api_version: "2010-04-01",
        body:
          "Sent from your Twilio trial account - Thanks for the message. Configure your number's SMS URL to change this message.Reply HELP for help.Reply STOP to unsubscribe.Msg&Data rates may apply.",
        date_created: "Thu, 22 Oct 2020 20:06:44 +0000",
        date_sent: "Thu, 22 Oct 2020 20:06:44 +0000",
        date_updated: "Thu, 22 Oct 2020 20:06:58 +0000",
        direction: "outbound-reply",
        error_code: nil,
        error_message: nil,
        from: "+16508259321",
        messaging_service_sid: nil,
        num_media: "0",
        num_segments: "2",
        price: nil,
        price_unit: "USD",
        sid: "SM523a6101f7aa8c2939487f550fd93479",
        status: "delivered",
        subresource_uri: nil,
        to: "+19193331749",
        uri:
          "/2010-04-01/Accounts/AC25b06f206bcb9576c2b90584cba42bb3/Messages/SM523a6101f7aa8c2939487f550fd93479.json"
      },
      %ExTwilio.Message{
        account_sid: "AC25b06f206bcb9576c2b90584cba42bb3",
        api_version: "2010-04-01",
        body: "I got your message",
        date_created: "Thu, 22 Oct 2020 20:06:44 +0000",
        date_sent: "Thu, 22 Oct 2020 20:06:44 +0000",
        date_updated: "Thu, 22 Oct 2020 20:06:44 +0000",
        direction: "inbound",
        error_code: nil,
        error_message: nil,
        from: "+19193331749",
        messaging_service_sid: nil,
        num_media: "0",
        num_segments: "1",
        price: nil,
        price_unit: "USD",
        sid: "SMfed7102b75f916024c8028ee420d5349",
        status: "received",
        subresource_uri: nil,
        to: "+16508259321",
        uri:
          "/2010-04-01/Accounts/AC25b06f206bcb9576c2b90584cba42bb3/Messages/SMfed7102b75f916024c8028ee420d5349.json"
      },
      %ExTwilio.Message{
        account_sid: "AC25b06f206bcb9576c2b90584cba42bb3",
        api_version: "2010-04-01",
        body: "Sent from your Twilio trial account - Hello World",
        date_created: "Sun, 18 Oct 2020 15:33:51 +0000",
        date_sent: "Sun, 18 Oct 2020 15:33:51 +0000",
        date_updated: "Sun, 18 Oct 2020 15:33:52 +0000",
        direction: "outbound-api",
        error_code: nil,
        error_message: nil,
        from: "+16508259321",
        messaging_service_sid: nil,
        num_media: "0",
        num_segments: "1",
        price: "-0.00750",
        price_unit: "USD",
        sid: "SM67192f2112534784b89f450495f27f5d",
        status: "delivered",
        subresource_uri: nil,
        to: "+19193331749",
        uri:
          "/2010-04-01/Accounts/AC25b06f206bcb9576c2b90584cba42bb3/Messages/SM67192f2112534784b89f450495f27f5d.json"
      }
    ]
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
