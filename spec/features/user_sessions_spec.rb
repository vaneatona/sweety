require 'rails_helper'

RSpec.feature "UserSessions" do
  before(:each) do
    activate_authlogic
    @newUser = create :user
  end

  describe "the signin process" do
    it "signs me in and out" do
      # sign_in defined in spec/support/auth_logic_helpers.rb
      sign_in(@newUser)
      expect(page).to have_content 'Welcome back!'

      click_link('sign-out')
      expect(page).to have_content 'Goodbye!'
    end

  end

end