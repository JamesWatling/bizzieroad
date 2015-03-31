class AddMoreDataToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :decision_maker, :string
    add_column :companies, :decision_maker_position, :string
    add_column :companies, :decision_maker_location, :string
    add_column :companies, :email, :string
    add_column :companies, :initial_contact_person, :string
    add_column :companies, :connections, :string
    add_column :companies, :connection_type, :string
    add_column :companies, :renewal_date, :datetime
    add_column :companies, :interest_level, :integer
    add_column :companies, :notes, :text
  end
end
