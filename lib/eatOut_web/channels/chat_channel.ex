defmodule EatOutWeb.ChatChannel do
  use EatOutWeb, :channel
  alias EatOut.Chats
  alias EatOut.Chats.Chat
  alias EatOut.Repo
  alias EatOut.Users
  alias EatOut.Friends

  def join("chats:" <> chat_id, payload, socket) do
    # if authorized?(payload) do
    #   {:ok, socket}
    # else
    #   {:error, %{reason: "unauthorized"}}
    # end
    #send(self(), :after_join)
    {:ok, %{channel: "chat:#{chat_id}"}, assign(socket, :chat_id, chat_id)}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (chat:lobby).
  def handle_in("shout", payload, socket) do
    IO.puts("REACHED")
    payload_wo_name = Map.drop(payload, ["name"])
    # Insert messages into database
    Chat.changeset(%Chat{}, payload_wo_name) |> Repo.insert
    chat_id = socket.assigns[:chat_id]
    broadcast socket, "chat:#{chat_id}:new_msg", payload
    {:noreply, socket}
  end

  # # Load the chat history when someone joins enters the chat
  # def handle_info(:after_join, socket) do
  #   chat_id = socket.assigns.chat_id 
  #   # Find a friendship
  #   friendship = Friends.get_friend!(chat_id)
  #   friend1_id = friendship.friender_id
  #   friend2_id = friendship.friendee_id
    
  #   loc = Chats.get_msgs(friend1_id, friend2_id)    # chat history obtained

  #   Enum.each(loc, fn msg -> 
  #     sender_id = elem(msg, 0)
  #     sender_name = Users.get_user!(sender_id).name
  #     push(socket, "shout", %{
  #       name: sender_name,
  #       message: elem(msg, 1),
  #       sender_id: sender_id,
  #       receiver_id: nil
  #       })
  #   end)
  #   {:noreply, socket}
  # end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
