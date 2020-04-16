class RoomsController < ApplicationController
  include CustomerAuthenticator
  before_action :registered_confirmation

  def enter
    @current_customer = current_customer
    @customer_room = current_customer.customer_room
    @room = @current_customer.room
    @messages = @room.messages

    render :show
  end
end
