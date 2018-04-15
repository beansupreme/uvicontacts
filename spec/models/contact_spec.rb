require 'rails_helper'

RSpec.describe Contact, type: :model do
  
  describe '.import' do
    let(:file_to_upload) do
      Rack::Test::UploadedFile.new(contact_file_path, 'text/csv')
    end
    
    let(:contact_file_path) do
      Rails.root.join('spec', 'support', contacts_list_file_name)
    end

    context 'with a csv that has a header' do
      context 'and multiple valid rows' do
        let(:contacts_list_file_name) do
          'contacts_list_with_five_records_and_header.csv'
        end

        it 'creates contacts for each record in the csv, and skips the header' do
          expect(Contact.count).to eq(0)

          Contact.import(file_to_upload)

          expect(Contact.count).to eq(5)
        end
      end

      context 'and is empty' do
        let(:contacts_list_file_name) do
          'invalid_contacts_list.csv'
        end

        it 'does not create any contacts' do
          expect{
            Contact.import(file_to_upload)
          }.not_to change(Contact, :count)
        end
      end
    end
  end
end
