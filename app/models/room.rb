class Room < ApplicationRecord
  has_one :customer_room, dependent: :destroy
  has_one :customer, through: :customer_room
  has_many :admin_rooms, dependent: :destroy
  has_many :admins, through: :admin_rooms
  has_many :messages

  def has_unread_message?(user)
    return false if messages.empty?

    if user.instance_of?(Customer)
      last_accessed_at = user.customer_rooms.last_accessed_at
    elsif user.instance_of?(Admin)
      last_accessed_at = AdminRoom.find_by(room_id: id, admin_id: user.id).last_accessed_at
    end

    return true if last_accessed_at.nil?

    messages.last.created_at > last_accessed_at
  end
end
