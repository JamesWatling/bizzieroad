class Company < ActiveRecord::Base
	belongs_to :user
  has_many :services
  has_many :providers, through: :services

  geocoded_by :full_address, :latitude  => :lat, :longitude => :lng 
  after_validation :geocode

  def provider_logo
    provider = get_provider
    if self.interest_level == 3
      provider.hot_icon.url
    else
      provider.default_icon.url 
    end
  end

  def full_address
    "#{address}, New Zealand"
  end

  def provider
    get_provider.name
  end

  def get_provider
    providers.first || Provider.find_by(name: 'Other')
  end

end
