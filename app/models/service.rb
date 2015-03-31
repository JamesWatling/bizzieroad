class Service < ActiveRecord::Base
  belongs_to :company
  belongs_to :provider
end
