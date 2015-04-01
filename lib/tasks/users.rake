require 'csv'

namespace :users do
  desc "TODO"
  task import_csv: :environment do
    csv_text = File.read('public/users.csv', :headers => true)
    csv = CSV.parse(csv_text)
    csv.each do |row|
      next if row == ["BSC", "TradingName", "Physical Address", "Decision Maker", "DM Position", "DM Location", "Contact No.", "Contact Email", "Initial Contact Person", "Connections", "Connection Type", "Current Provider", "Renewal Date", "Interest Level", "Notes"]
        company = Company.create(
        rep_name: row[0],
        name: row[1],
        address: row[2],
        decision_maker: row[3],
        decision_maker_position: row[4],
        decision_maker_location: row[5],
        phone_number: row[6],
        email: row[7],
        initial_contact_person: row[8],
        connections: row[9],
        connection_type: row[10],
        renewal_date: row[12],
        interest_level: row[13],
        notes: row[14]
      )
      provider = Provider.find_by(name: row[11].titleize) if row[11].present? 
      if provider
        Service.create(provider_id: provider.id, company_id: company.id)
      end
    end
  end


  task update_csv: :environment do
    csv_text = File.read('public/users.csv', :headers => true)
    csv = CSV.parse(csv_text)
    csv.each do |row|
      next if row == ["BSC", "TradingName", "Physical Address", "Decision Maker", "DM Position", "DM Location", "Contact No.", "Contact Email", "Initial Contact Person", "Connections", "Connection Type", "Current Provider", "Renewal Date", "Interest Level", "Notes"]
        company = Company.find_by(name: row[1])
        company.update_attributes(
        rep_name: row[0],
        address: row[2],
        decision_maker: row[3],
        decision_maker_position: row[4],
        decision_maker_location: row[5],
        phone_number: row[6],
        email: row[7],
        initial_contact_person: row[8],
        connections: row[9],
        connection_type: row[10],
        renewal_date: row[12],
        interest_level: row[13],
        notes: row[14]
      )
      provider = Provider.find_by(name: row[11].titleize) if row[11].present? 
      if provider
        #Service.create(provider_id: provider.id, company_id: company.id)
      end
    end
  end

end

