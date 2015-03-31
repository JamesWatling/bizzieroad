class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.integer :user_id
      t.string :name
      t.string :address
      t.string :phone_number
      t.string :current_provider

      t.timestamps
    end
  end
end
