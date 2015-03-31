class AddCurrentProvidersToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :provider_id, :integer
    remove_column :companies, :current_provider
    add_index :companies, :provider_id
  end
end
