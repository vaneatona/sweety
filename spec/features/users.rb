require 'rails_helper'

RSpec.feature "Users" do
  before(:each) do
    activate_authlogic
    @newUser = create :user
  end

  describe "the user creation process" do
    it "it creates a new user" do
      visit '/'
      click_link('sign-up')
      expect(current_path).to eq(new_user_path)
      within("#new_user") do
        fill_in 'user_email', :with => @newUser.email
        fill_in 'user_password', :with => @newUser.password
        fill_in 'user_password_confirmation', :with => @newUser.password
      end
      click_button 'Register'
      # save_and_open_page
      expect(current_path).to eq(user_readings_path(@newUser))
      expect(page).to have_content 'Account registered!'
    end

    it "it gives errors when they occur" do
      visit '/'
      click_link('sign-up')
      expect(current_path).to eq(new_user_path)
      within("#new_user") do
        fill_in 'user_email', :with => @newUser.email
        fill_in 'user_password', :with => @newUser.password
        fill_in 'user_password_confirmation', :with => 'wrong-password'
      end
      click_button 'Register'
      # save_and_open_page
      expect(page).to have_content "Password confirmation doesn't match Password"
    end
  end

  describe "the users as a 'resource'" do
    pending "add some examples to (or delete) #{__FILE__}"
    # view
    # edit
    # cannot view/edit another's
  end

end