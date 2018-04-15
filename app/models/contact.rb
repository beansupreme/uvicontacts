class Contact < ActiveRecord::Base
  require 'csv'

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      puts row.header_row?
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
end
