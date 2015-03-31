class AddAttachmentDefaultIconToProviders < ActiveRecord::Migration
  def self.up
    change_table :providers do |t|
      t.attachment :default_icon
    end
  end

  def self.down
    remove_attachment :providers, :default_icon
  end
end
