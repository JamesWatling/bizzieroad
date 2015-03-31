class Provider < ActiveRecord::Base

  has_attached_file :default_icon, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :default_icon, :content_type => /\Aimage\/.*\Z/

  attr_accessor :default_icon_file_name

  belongs_to :industry
  has_many :customers, through: :providers
end
