require 'rails_helper'

RSpec.describe "contacts/index", type: :view do
  let!(:contacts_list) do
    [
      Contact.create!(
        :name => "Name",
        :telephone => "Telephone",
        :emergency_contact_name => "Emergency Contact Name",
        :emergency_contact_telephone => "Emergency Contact Telephone"
      ),
      Contact.create!(
        :name => "Name",
        :telephone => "Telephone",
        :emergency_contact_name => "Emergency Contact Name",
        :emergency_contact_telephone => "Emergency Contact Telephone"
      )
    ]
  end

  before(:each) do
    assign(:contacts, Contact.paginate(page: 1))
  end

  it "renders a list of contacts" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Telephone".to_s, :count => 2
    assert_select "tr>td", :text => "Emergency Contact Name".to_s, :count => 2
    assert_select "tr>td", :text => "Emergency Contact Telephone".to_s, :count => 2
  end
end
