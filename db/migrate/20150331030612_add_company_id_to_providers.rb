class AddCompanyIdToProviders < ActiveRecord::Migration
  def change
    remove_column :providers, :compay_id
    add_column :providers, :company_id, :integer
  end
end
