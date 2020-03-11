module Admins
  class RoomsController < ApplicationController
    before_action :authenticate_admin!

    def index
      @current_admin = current_admin
      @rooms = current_admin.rooms
    end

    def show
      @room = Room.find(params[:id])
      @messages = @room.messages
    end
  end
end