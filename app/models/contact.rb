class Contact < ActiveRecord::Base
  require 'csv'

  def self.import(file)
    index = 0
    CSV.foreach(file.path, headers: true) do |row|
      index += 1
      next if index == 1
      create_contact_from_csv_row(row)
    end
  end

  private

  def self.create_contact_from_csv_row(row)
    if row[0].present?
      Contact.create!(
        name: row[0], 
        telephone: row[1], 
        emergency_contact_name: row[2],
        emergency_contact_telephone: row[3]
      )
    end
  end
end
