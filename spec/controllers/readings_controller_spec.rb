require 'rails_helper'

RSpec.describe ReadingsController do
  before(:each) do
    activate_authlogic
    @newUser = User.create!(
      id: '1',
      email: 'hooa@aol.com',
      password: 'secret1',
      password_confirmation: 'secret1'
    )
    @newUser.save(:validate => false)
    log_in(@newUser)

    @newReading = @newUser.readings.create!(
      title: 'NewReadingforFakeUser',
      blood_sugar: '5'
    )
    @newReading.save(:validate => false)
  end

  describe "GET #index" do
    it "it returns a listing of all users readings" do
      get :index, {:user_id => @newUser.id}
      # Currently fragile, fails if database isn't empty for test
      expect(assigns(:readings)).to eq([@newReading])
    end
  end

  describe "GET #show" do
    it "it returns a specific reading for your viewing pleasure" do
      get :show, {:user_id => @newUser.id, :id => @newReading.id}
      expect(assigns(:reading)).to eq(@newReading)
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "it renders the new template" do
      get :new, {:user_id => @newUser.id}
      expect(response).to render_template(:new)
    end
  end

  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #create" do
  #   it "returns http success" do
  #     get :create
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #update" do
  #   it "returns http success" do
  #     get :update
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #destroy" do
  #   it "returns http success" do
  #     get :destroy
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end