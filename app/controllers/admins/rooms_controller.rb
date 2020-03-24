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
      @admin_room.update_attribute(:latest_read_message_id, @room.messages.last.id)
      @messages = @room.messages
    end
  end
end