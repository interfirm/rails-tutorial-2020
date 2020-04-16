class ChangeColumnCustomerRooms < ActiveRecord::Migration[5.2]
  def change
    remove_column :customer_rooms, :last_accessed_at, :datetime
    add_reference :customer_rooms, :last_read_message, foreign_key: { to_table: :messages }
  end
end
