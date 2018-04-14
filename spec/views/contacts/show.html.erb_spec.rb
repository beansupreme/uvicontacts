require 'rails_helper'

RSpec.describe "contacts/show", type: :view do
  before(:each) do
    @contact = assign(:contact, Contact.create!(
      :name => "Name",
      :telephone => "Telephone",
      :emergency_contact_name => "Emergency Contact Name",
      :emergency_contact_telephone => "Emergency Contact Telephone"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Telephone/)
    expect(rendered).to match(/Emergency Contact Name/)
    expect(rendered).to match(/Emergency Contact Telephone/)
  end
end
