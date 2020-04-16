class ChangeColumnAdminRooms < ActiveRecord::Migration[5.2]
  def change
    remove_column :admin_rooms, :last_accessed_at, :datetime
    add_reference :admin_rooms, :last_read_message, foreign_key: { to_table: :messages }
  end
end
