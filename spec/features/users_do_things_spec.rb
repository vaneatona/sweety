require 'rails_helper'

RSpec.feature "UsersDoThings" do
  before(:each) do
    activate_authlogic
    @newUser = create :user_with_many_readings_created_from_all_dates
    @newReading = create :reading, { user: @newUser, title: 'Fancy Reading' }
    sign_in(@newUser)
  end

  describe "users have readings," do
    it "they can see their readings" do
      expect(page).to have_content 'Fancy Reading'
    end

    it "they can view only their own readings" do
      # setup
      differentUser = create :user_with_readings

      visit user_readings_path(differentUser)
      expect(page).to have_content 'Access denied.'
      expect(current_path).to eq user_readings_path(@newUser)
    end

    it "they can create them" do
      # setup
      stub = build_stubbed(:reading, user: @newUser)

      click_link("New Reading")
      within("#new_reading") do
        fill_in 'reading_title', :with => stub.title
        fill_in 'reading_blood_sugar', :with => stub.blood_sugar
      end

      click_button 'Create Reading'
      expect(current_path).to eq user_readings_path(@newUser)
      expect(page).to have_content stub.title
      # save_and_open_page
    end

    it "they can edit them" do
      # setup
      stub = build_stubbed(:reading, title: 'edited-title')

      first(:link, 'edit-reading').click # new
      fill_in 'reading_title', :with => stub.title
      click_button 'Update Reading'
      expect(page).to have_content stub.title
    end

    it "they can delete readings" do
      # setup, we need to ensure we know the title of this one
      reading1 = create :reading, { user: @newUser, title: 'DELETE ME!' }

      visit current_path
      expect(page).to have_content reading1.title

      page.find('tr', :text => reading1.title).click_link('delete-reading')
      # save_and_open_page
      expect(page).not_to have_content reading1.title
    end

  end

  # This requires gem 'selenium-webdriver' which made my sign_in helper fail.
  # TODO: I'll revisit.
  describe "users run reports," do
    pending "they can interact with the calendar #{__FILE__}"
    # it 'they can interact with the calendar', :js => true do
    #   visit 'readings/reports/daily'
    #   expect(page).to have_content 'Reports#daily'
    # end
  end

end