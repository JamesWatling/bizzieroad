class AddAttachmentHotIconToProviders < ActiveRecord::Migration
  def self.up
    change_table :providers do |t|
      t.attachment :hot_icon
    end
  end

  def self.down
    remove_attachment :providers, :hot_icon
  end
end
