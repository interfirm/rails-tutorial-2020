class Admin < ApplicationRecord
  include Messageable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :admin_rooms, dependent: :destroy
  has_many :rooms, through: :admin_rooms

  # messageable interface
  def sender_display_name
    'サポート'
  end
end
