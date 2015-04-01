class Company < ActiveRecord::Base
	belongs_to :user
  has_many :services
  has_many :providers, through: :services

  geocoded_by :full_address, :latitude  => :lat, :longitude => :lng 
  after_validation :geocode

  def provider_logo
    if providers.first.nil?
      Provider.find_by(name: 'Other').default_icon.url
    else
      providers.first.default_icon.url 
    end
  end

  def full_address
    "#{address}, New Zealand"
  end

  def provider
    if providers.first.nil?
      Provider.find_by(name: 'Other').name
    else
      providers.first.name
    end
  end
end
