collection @companies, object_root: false
attributes :id, :address, :phone_number, :lat, :lng
attribute :name => :company
attribute :providers => :isp
attribute :provider_logo => asset_path(:logo)
attribute :id => :index
attribute :user_id => :users