module Api
  class RoomsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def update
      CustomerRoom.find_by(id: params[:id]).update_attribute(:latest_read_message_id, params[:message_id])
      response = [status: 200, id: params[:message_id]]
      render json: response
    end
  end
end
