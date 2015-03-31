class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.references :industry, index: true
      t.string :name
      t.string :logo

      t.timestamps
    end
  end
end
