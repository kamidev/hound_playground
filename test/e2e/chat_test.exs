defmodule HoundPlayground.ChatTest do
  use HoundPlayground.ConnCase
  use Hound.Helpers

  hound_session

  defp chat_index do
    chat_url(HoundPlayground.Endpoint, :index)
  end

  defp parse_message(message) do
    [_match, pid, text] = Regex.run(~r/\[(.*?)\] (.*)/, message)
    %{pid: pid, text: text}
  end

  defp send_message(message) do
    navigate_to(chat_index())
    chat_input2 = find_element(:id, "chat-input")
    chat_input2 |> fill_field(message)
    send_keys(:enter)
    :timer.sleep(1000)
  end

  test "receive chat from another session" do
    send_message("Hello from session 1")
    change_session_to("session2")
    send_message("Message from session 2")
    change_to_default_session()

    messages = find_element(:id, "messages")
    [msg1, msg2] = messages 
    |> find_all_within_element(:tag, "li")
    |> Enum.map(&inner_text/1)
    |> Enum.map(&parse_message/1)

    assert msg1.text == "Hello from session 1"
    assert msg2.text == "Message from session 2"
    assert msg1.pid != msg2.pid
  end
end
