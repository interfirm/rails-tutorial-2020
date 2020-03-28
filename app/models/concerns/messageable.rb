module Messageable
  extend ActiveSupport::Concern

  included do
    has_many :messages, as: :messageable
  end

  def sender_dispaly_name
    raise NotImplementedError
  end
end