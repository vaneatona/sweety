require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns the new view" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET #show" do
    let(:newUser) { create :user }

    it "it shows the specified user" do
      get :show, { id: newUser.id }
      expect(assigns(:user)).to eq(newUser)
      expect(response).to render_template(:show)
    end
  end

  describe "POST #create" do
    let(:attrs) { attributes_for(:user) }

    it "it creates a user and redirects to readings" do
      expect{
        post :create, user: attrs
      }.to change(User, :count).by(1)
    end
  end

end