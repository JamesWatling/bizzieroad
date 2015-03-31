class Company < ActiveRecord::Base
	belongs_to :user
  has_many :services
  has_many :providers, through: :services

  geocoded_by :full_address, :latitude  => :lat, :longitude => :lng 
  after_validation :geocode

  def provider_logo
    providers.first.logo unless providers.first.nil?
  end


  def full_address
    "#{address}, New Zealand"
  end
end
