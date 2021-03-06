class Provider < ActiveRecord::Base

  has_attached_file :default_icon, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :default_icon, :content_type => /\Aimage\/.*\Z/

  has_attached_file :hot_icon, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :hot_icon, :content_type => /\Aimage\/.*\Z/

  belongs_to :industry
  has_many :customers, through: :providers
end
