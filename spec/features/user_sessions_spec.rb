require 'rails_helper'

RSpec.feature "UserSessions" do
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

  describe "the signin process" do
    it "signs me in" do
      visit '/sign_in'
      within("#new_user_session") do
        fill_in 'user_session_email', :with => @newUser.email
        fill_in 'user_session_password', :with => @newUser.password
      end
      # save_and_open_page
      click_button 'Log in!'
      expect(current_path).to eq("/users/#{@newUser.id}/readings")
      expect(page).to have_content 'Welcome back!'
    end
  end

  describe "the sign-out process" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

end