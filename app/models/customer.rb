class Customer < ApplicationRecord
  include Messageable
  attr_accessor :remember_token
  has_one :customer_room, dependent: :destroy
  has_one :room, through: :customer_room

  # messageable interface
  def sender_display_name
    'ゲスト'
  end

  def registration
    self.remember_token = new_token
    update_attribute(:remember_digest, digest(remember_token))
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def new_token
    SecureRandom.urlsafe_base64
  end
end
