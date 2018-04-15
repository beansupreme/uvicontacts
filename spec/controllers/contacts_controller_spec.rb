require 'rails_helper'

RSpec.describe ContactsController, type: :controller do

  include Devise::Test::ControllerHelpers

  let!(:test_user) do
    User.create(email: 'test@user.com', password: 'Password!')
  end

  shared_context 'with a logged in user' do
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]

      sign_in test_user

    end
  end

  # This should return the minimal set of attributes required to create a valid
  # Contact. As you add validations to Contact, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      name: 'Test Contact',
      telephone: '440-123-5123',
      emergency_contact_name: 'Mother',
      emergency_contact_telephone: '332-123-4123'
    }
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ContactsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    include_context 'with a logged in user'

    it "returns a success response" do
      contact = Contact.create! valid_attributes
      get :index, {}, valid_session
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    include_context 'with a logged in user'

    it "returns a success response" do
      contact = Contact.create! valid_attributes
      get :show, {:id => contact.to_param}, valid_session
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    include_context 'with a logged in user'

    it "returns a success response" do
      get :new, {}, valid_session
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    include_context 'with a logged in user'
    it "returns a success response" do
      contact = Contact.create! valid_attributes
      get :edit, {:id => contact.to_param}, valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    include_context 'with a logged in user'

    context "with valid params" do
      it "creates a new Contact" do
        expect {
          post :create, {:contact => valid_attributes}, valid_session
        }.to change(Contact, :count).by(1)
      end

      it "redirects to the created contact" do
        post :create, {:contact => valid_attributes}, valid_session
        expect(response).to redirect_to(Contact.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, {:contact => invalid_attributes}, valid_session
        expect(response).to be_success
      end
    end
  end


  describe 'POST #import' do
    let(:file_to_upload) do
      Rack::Test::UploadedFile.new(contact_file_path, 'text/csv')
    end

    let(:contacts_list_file_name) do
      'contacts_list.csv'
    end
    let(:contact_file_path) do
      Rails.root.join('spec', 'support', contacts_list_file_name)
    end
    let(:post_params) do
      {
        file: file_to_upload
      }
    end

    let(:action) { post :import, post_params }

    include_context 'with a logged in user'

    it 'creates contact records' do
      
      expect{action}.to change(Contact, :count)
    end

    it 'redirects to the contacts list' do
      action 

      expect(response).to redirect_to(contacts_url)
    end

    it 'throws an error with badly formatted params' do
      expect{
        post :import, {}
      }.to raise_error
    end
  end

  describe "PUT #update" do
    include_context 'with a logged in user'

    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested contact" do
        contact = Contact.create! valid_attributes
        put :update, {:id => contact.to_param, :contact => new_attributes}, valid_session
        contact.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the contact" do
        contact = Contact.create! valid_attributes
        put :update, {:id => contact.to_param, :contact => valid_attributes}, valid_session
        expect(response).to redirect_to(contact)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        contact = Contact.create! valid_attributes
        put :update, {:id => contact.to_param, :contact => invalid_attributes}, valid_session
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    include_context 'with a logged in user'

    it "destroys the requested contact" do
      contact = Contact.create! valid_attributes
      expect {
        delete :destroy, {:id => contact.to_param}, valid_session
      }.to change(Contact, :count).by(-1)
    end

    it "redirects to the contacts list" do
      contact = Contact.create! valid_attributes
      delete :destroy, {:id => contact.to_param}, valid_session
      expect(response).to redirect_to(contacts_url)
    end
  end

  describe "DELETE #destroy_multiple" do
    include_context 'with a logged in user'
    let!(:contact_one) do
      Contact.create!(valid_attributes)
    end
    let!(:contact_two) do
      Contact.create!(valid_attributes)
    end

    it "destroys the requested contacts" do
      contact_three = Contact.create! valid_attributes

      expect {
        delete :destroy_multiple, {:ids => [contact_one.id, contact_two.id] }, valid_session
      }.to change(Contact, :count).by(-2)

      expect(Contact.find_by_id(contact_one.id)).not_to be_present
      expect(Contact.find_by_id(contact_two.id)).not_to be_present
      expect(Contact.find_by_id(contact_three.id)).to be_present
    end

    it "redirects to the contacts list" do
      delete :destroy_multiple, {:ids => [contact_one.id, contact_two.id]}, valid_session
      expect(response).to redirect_to(contacts_url)
    end
  end
end
