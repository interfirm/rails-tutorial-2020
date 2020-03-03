module CustomerAuthenticator
  def register(admin)
    customer = Customer.create
    customer.registration
    cookies.permanent.signed[:customer_id] = customer.id
    cookies.permanent[:remember_token] = customer.remember_token
    room = Room.create
    room.create_customer_room(customer: customer)
    room.admin_rooms.create!(admin: admin)
  end

  def current_customer
    return unless (customer_id = cookies.signed[:customer_id])

    customer = Customer.find_by(id: customer_id)
    return unless customer&.authenticated?(cookies[:remember_token])

    customer
  end

  def registered_confirmation(admin_id:)
    admin = Admin.find_by(id: admin_id)
    return unless admin

    register(admin) unless current_customer
  end
end
