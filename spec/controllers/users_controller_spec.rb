require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns the new view" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET #show" do
    it "it shows the specified user" do
      newUser = User.create!(
        id: '1',
        email: 'hooa@aol.com',
        password: 'secret1',
        password_confirmation: 'secret1'
      )
      get :show, {:id => newUser.id}
      expect(assigns(:user)).to eq(newUser)
      expect(response).to render_template(:show)
    end
  end

  describe "POST #create" do
    it "it creates a user and redirects to readings" do
      expect{
        post :create, :user => {:email => 'newUser@aol.com', :password => 'secret1', :password_confirmation => 'secret1'}
      }.to change(User, :count).by(1)

      # Since we're using transactions, this will always be first user
      expect(response).to redirect_to('/users/1/readings')
    end
  end

end