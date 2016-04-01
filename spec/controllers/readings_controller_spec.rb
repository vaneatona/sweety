require 'rails_helper'

RSpec.describe ReadingsController do
  before(:each) do
    activate_authlogic
  end

  describe "GET #index" do
    let(:newUser) { create :user_with_readings }

    it "it returns a listing of all users readings" do
      get :index, {:user_id => newUser.id}
      expect(assigns(:readings)).to eq(newUser.readings)
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    let(:newUser) { create :user_with_readings }

    it "it returns the first reading for your viewing pleasure" do
      # Checks the first reading
      get :show, {:user_id => newUser.id, :id => newUser.readings.first.id}
      expect(assigns(:reading)).to eq(newUser.readings.first)
      expect(response).to render_template(:show)
    end

    it "it returns the last reading for your viewing pleasure" do
      # Checks the last, to ensure we're actually choosing
      get :show, {:user_id => newUser.id, :id => newUser.readings.last.id}
      expect(assigns(:reading)).to eq(newUser.readings.last)
      expect(response).to render_template(:show)
    end

  end

  describe "GET #new" do
    let(:newUser) { create :user_with_readings }
    let(:differentUser) { create :user_with_many_readings }

    it "it renders the new template" do
      get :new, {:user_id => newUser.id}
      expect(response).to render_template(:new)
    end

    it "it redirects if you are above daily reading limit" do
      get :new, {:user_id => differentUser.id}
      expect(response).to redirect_to user_readings_path(differentUser)
    end

  end

  describe "GET #edit" do
    let(:newUser) { create :user_with_readings }

    it "it renders the edit template" do
      get :new, {:user_id => newUser.id}
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    let(:newUser) { create :user_with_readings }
    let(:attrs) { attributes_for(:reading) }
    let(:differentUser) { create :user_with_many_readings }

    it "creates a new reading" do
      # setup
      userReadings = newUser.readings

      expect{
        post :create, {:user_id => newUser.id, :reading => attrs}
      }.to change(userReadings, :count).by(1)
    end

    it "it redirects if you are above daily reading limit" do
      # post :create, {:user_id => differentUser.id, :reading => attrs}
      # expect(response).to redirect_to user_readings_path(differentUser)
      differentUserReadings = differentUser.readings

      expect{
        post :create, {:user_id => differentUser.id, :reading => attrs}
      }.to change(differentUserReadings, :count).by(0)
    end

  end

  # describe "GET #update" do
  #   let(:newUser) { create :user_with_readings }
  #   let(:reading) { create :reading, title: 'UPDATE ME' }
  #   let(:attrs) { attributes_for(:reading) }

  #   it "updates a reading" do
  #     # setup
  #     userReadings = newUser.readings

  #     print attrs
  #     expect{
  #       post :update, {user_id: newUser.id, id: reading.id, reading: attrs}
  #     }.to change(userReadings.find(reading.id), :title)
  #   end
  # end

  # describe "GET #destroy" do
  #   it "returns http success" do
  #     get :destroy
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end