class Room < ApplicationRecord
  has_one :customer_room, dependent: :destroy
  has_one :customer, through: :customer_room
  has_many :admin_rooms, dependent: :destroy
  has_many :admins, through: :admin_rooms
  has_many :messages

  def has_unread_message?(user)
    return false if messages.empty?

    if user.instance_of?(Customer)
      last_read_message_id = user.customer_room.last_read_message_id
    elsif user.instance_of?(Admin)
      last_read_message_id = AdminRoom.find_by(room_id: id, admin_id: user.id).last_read_message_id
    end

    return true if last_read_message_id.nil?

    messages.last.id != last_read_message_id
  end
end
