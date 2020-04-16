module Admins
  class RoomsController < ApplicationController
    before_action :authenticate_admin!

    def index
      @current_admin = current_admin
      @rooms = current_admin.rooms
    end

    def show
      @room = Room.find(params[:id])
      @admin_room = AdminRoom.find_by(room_id: params[:id], admin_id: current_admin.id)
      @messages = @room.messages
      @admin_room.update_attribute(:latest_read_message_id, @room.messages.last.id) if @messages.exists?
    end
  end
end