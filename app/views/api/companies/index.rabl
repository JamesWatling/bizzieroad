collection @companies, object_root: false
attributes :id, :address, :phone_number, :lat, :lng, :rep_name, :decision_maker, :decision_maker_position, :decision_maker_location, :phone_number, :email, :connections, :connection_type, :interest_level, :notes
attribute :name => :company
attribute :provider => :isp
attribute :provider_logo => :logo
attribute :id => :index
attribute :user_id => :users

