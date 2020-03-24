class RenameLastReadMessageIdColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :customer_rooms, :last_read_message_id, :latest_read_message_id
    rename_column :admin_rooms, :last_read_message_id, :latest_read_message_id
  end
end
