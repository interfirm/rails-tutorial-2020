class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    RoomChannel.broadcast_to(
      message.room.id,
      message: message.content,
      timestamp: message.created_at.strftime('%R'),
      room_id: message.room.id,
      message_id: message.id,
      sender: message.messageable_type,
      sender_display_name: message.messageable.sender_display_name
    )
  end
end
