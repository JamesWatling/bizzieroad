class Provider < ActiveRecord::Base
  belongs_to :industry
  has_many :customers, through: :providers
end
