class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    RoomChannel.broadcast_to(
      message.room.id,
      message: message.content,
      timestamp: message.created_at.in_time_zone('Tokyo').strftime('%R'),
      room_id: message.room.id,
      message_id: message.id,
      sender: message.messageable.sender_name
    )
  end
end
