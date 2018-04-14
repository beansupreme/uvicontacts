class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :telephone
      t.string :emergency_contact_name
      t.string :emergency_contact_telephone

      t.timestamps null: false
    end
  end
end
