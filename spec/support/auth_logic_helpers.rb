def sign_in(user)
  expect(user).not_to be_nil
  visit '/'
  click_link('sign-in')
  within("#new_user_session") do
    fill_in 'user_session_email', :with => user.email
    fill_in 'user_session_password', :with => user.password
  end

  click_button 'Log in!'
  expect(page).to have_content 'Welcome back!'
  expect(current_path).to eq user_readings_path(user)
end