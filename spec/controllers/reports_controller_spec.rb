require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  before(:each) do
    activate_authlogic
    @newUser = User.create!(
      id: '1',
      email: 'hooa@aol.com',
      password: 'secret1',
      password_confirmation: 'secret1'
    )
    log_in(@newUser)
    @newReading = @newUser.readings.create!(
      title: 'fakereading1',
      blood_sugar: '5',
      created_at: Time.now,
      user_id: @newUser.id
    )
    @newReading2 = @newUser.readings.create!(
      title: 'fakereading2 - correct',
      blood_sugar: '5',
      created_at: 2.days.ago,
      user_id: @newUser.id
    )
    @newReading3 = @newUser.readings.create!(
      title: 'fakereading3 - correct',
      blood_sugar: '5',
      created_at: 2.days.ago,
      user_id: @newUser.id
    )
    @newReading4 = @newUser.readings.create!(
      title: 'fakereading4',
      blood_sugar: '5',
      created_at: 5.days.ago,
      user_id: @newUser.id
    )
    @newReading5 = @newUser.readings.create!(
      title: 'fakereading4',
      blood_sugar: '5',
      created_at: 2.months.ago,
      user_id: @newUser.id
    )
  end

  describe "GET #daily" do
    it "it defaults to today" do
      get :daily, {:user_id => @newUser.id}
      expect(assigns(:report_end).to_i).to eq(Time.now.to_i)
    end

    it "it accepts user input for date" do
      get :daily, {:user_id => @newUser.id, :report_end => 2.days.ago}
      # Time matches the selected time
      expect(assigns(:report_end).to_i).to eq(2.days.ago.to_i)
      # Time isn't the default value
      expect(assigns(:report_end).to_i).not_to eq(Time.now.to_i)
    end

    it "it returns reports from selected day only" do
      get :daily, {:user_id => @newUser.id, :report_end => 2.days.ago}
      expect(assigns(:report)).to contain_exactly(@newReading2, @newReading3)
    end
  end

  describe "GET #monthly" do
    it "it defaults to this month" do
      get :monthly, {:user_id => @newUser.id}
      expect(assigns(:report_end).to_i).to eq(Time.now.to_i)
    end

    it "it accepts user input for date" do
      get :monthly, {:user_id => @newUser.id, :report_end => 2.months.ago}
      # Time matches the selected time
      expect(assigns(:report_end).to_i).to eq(2.months.ago.to_i)
      # Time isn't the default value
      expect(assigns(:report_end).to_i).not_to eq(Time.now.to_i)
    end

    it "it returns reports from selected month only" do
     get :monthly, {:user_id => @newUser.id, :report_end => 2.months.ago}
      expect(assigns(:report)).to contain_exactly(@newReading5)
    end

  end

  describe "GET #monthToDate" do
    it "it defaults to this month" do
      get :monthToDate, {:user_id => @newUser.id}
      expect(assigns(:report_end).to_i).to eq(Time.now.to_i)
      expect(assigns(:report_start).to_i).to eq(Time.now.to_i)
    end

    it "it accepts user input for a range" do
      get :monthToDate, {:user_id => @newUser.id, :report_end => 1.months.ago, :report_start => 2.months.ago}
      # Time matches the selected time
      expect(assigns(:report_end).to_i).to eq(1.months.ago.to_i)
      expect(assigns(:report_start).to_i).to eq(2.months.ago.to_i)
      # Time isn't the default value
      expect(assigns(:report_end).to_i).not_to eq(Time.now.to_i)
    end

    it "it returns reports from selected range only" do
     get :monthToDate, {:user_id => @newUser.id, :report_end => 2.days.ago, :report_start => 5.days.ago}
      expect(assigns(:report)).to contain_exactly(@newReading2, @newReading3, @newReading4)
    end
  end

end