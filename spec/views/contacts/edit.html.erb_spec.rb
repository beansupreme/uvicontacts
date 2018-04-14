require 'rails_helper'

RSpec.describe "contacts/edit", type: :view do
  before(:each) do
    @contact = assign(:contact, Contact.create!(
      :name => "MyString",
      :telephone => "MyString",
      :emergency_contact_name => "MyString",
      :emergency_contact_telephone => "MyString"
    ))
  end

  it "renders the edit contact form" do
    render

    assert_select "form[action=?][method=?]", contact_path(@contact), "post" do

      assert_select "input#contact_name[name=?]", "contact[name]"

      assert_select "input#contact_telephone[name=?]", "contact[telephone]"

      assert_select "input#contact_emergency_contact_name[name=?]", "contact[emergency_contact_name]"

      assert_select "input#contact_emergency_contact_telephone[name=?]", "contact[emergency_contact_telephone]"
    end
  end
end
