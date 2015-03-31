class AddRepToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :rep_name, :string
  end
end
