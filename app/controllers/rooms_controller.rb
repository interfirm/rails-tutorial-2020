class RoomsController < ApplicationController
  include CustomerAuthenticator
  before_action -> { registered_confirmation(admin_id: params[:chat_id]) }

  def enter
    return render :show unless Admin.find_by(id: params[:chat_id])

    @current_customer = current_customer
    @customer_room = current_customer.customer_room
    @room = @current_customer.room
    @messages = @room.messages

    render :show
  end
end
