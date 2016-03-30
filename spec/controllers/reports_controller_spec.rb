require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  before(:each) do
    activate_authlogic
    @newUser = create :user_with_many_readings_created_from_all_dates
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
      reading1 = create :reading, { user: @newUser, created_at: 2.days.ago }
      reading2 = create :reading, { user: @newUser, created_at: 2.days.ago }

      get :daily, {:user_id => @newUser.id, :report_end => 2.days.ago}
      expect(assigns(:report)).to contain_exactly(reading1, reading2)
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
      reading1 = create :reading, { user: @newUser, created_at: 2.months.ago }
      reading2 = create :reading, { user: @newUser, created_at: 2.months.ago }

      get :monthly, {:user_id => @newUser.id, :report_end => 2.months.ago}
      expect(assigns(:report)).to contain_exactly(reading1, reading2)
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
      reading1 = create :reading, { user: @newUser, created_at: 3.days.ago }
      reading2 = create :reading, { user: @newUser, created_at: 4.days.ago }

      get :monthToDate, {:user_id => @newUser.id, :report_end => 2.days.ago, :report_start => 5.days.ago}
      expect(assigns(:report)).to contain_exactly(reading1, reading2)
    end
  end

end