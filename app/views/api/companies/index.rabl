collection @companies, object_root: false
attributes :id, :address, :phone_number, :lat, :lng
attribute :name => :company
attribute :provider => :isp
attribute :provider_logo => :logo
attribute :id => :index
attribute :user_id => :users