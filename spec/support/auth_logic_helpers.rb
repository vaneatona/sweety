def log_in(user)
  expect(user).not_to be_nil
  session = UserSession.create!(user, false)
  expect(session).to be_valid
  session.save
end