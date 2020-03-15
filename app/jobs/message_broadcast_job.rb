class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    sender = message.messageable.sender_name == 'ゲスト' ? 'customer' : 'admin'
    RoomChannel.broadcast_to(message.room.id, message: render_message(message), room_id: message.room.id, message_id: message.id, sender: sender)
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
  end
end
