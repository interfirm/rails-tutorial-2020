class RoomChannel < ApplicationCable::Channel
  def subscribed
    return stream_for current_user.room.id if current_user.instance_of?(Customer)

    current_user.rooms.each do |room|
      stream_for room.id
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    ActiveRecord::Base.transaction do
      message = current_user.messages.create!(content: data['message'], room: Room.find_by(id: data['room_id']))

      logger.debug('customer')
      logger.debug(data['sender'])
      if data['sender'] == 'Customer'
        logger.debug('customer_update')
        current_user.customer_room.update!(latest_read_message_id: message.id)
      elsif data['sender'] == 'Admin'
        AdminRoom.find_by(room_id: data['room_id'], admin_id: current_user.id).update!(latest_read_message_id: message.id)
      end
    end
  end
end
