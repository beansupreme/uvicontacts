require 'rails_helper'

RSpec.describe "contacts/new", type: :view do
  before(:each) do
    assign(:contact, Contact.new(
      :name => "MyString",
      :telephone => "MyString",
      :emergency_contact_name => "MyString",
      :emergency_contact_telephone => "MyString"
    ))
  end

  it "renders new contact form" do
    render

    assert_select "form[action=?][method=?]", contacts_path, "post" do

      assert_select "input#contact_name[name=?]", "contact[name]"

      assert_select "input#contact_telephone[name=?]", "contact[telephone]"

      assert_select "input#contact_emergency_contact_name[name=?]", "contact[emergency_contact_name]"

      assert_select "input#contact_emergency_contact_telephone[name=?]", "contact[emergency_contact_telephone]"
    end
  end
end
