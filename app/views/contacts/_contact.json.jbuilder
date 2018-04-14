json.extract! contact, :id, :name, :telephone, :emergency_contact_name, :emergency_contact_telephone, :created_at, :updated_at
json.url contact_url(contact, format: :json)
