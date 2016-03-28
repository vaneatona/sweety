RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  # config.before(:suite) do
  #   begin
  #     DatabaseCleaner.start
  #     FactoryGirl.lint
  #   ensure
  #     DatabaseCleaner.clean # needs database_cleaner gem
  #   end
  # end

end

# Defines a new sequence
FactoryGirl.define do
  sequence :email do |n|
    "fakeuser#{n}@example.com"
  end

  sequence :reading_title do |n|
    "ReadingTitle#{n}"
  end
end


# This will guess the User class
FactoryGirl.define do
  factory :user do
    email { generate(:email) }
    password  'secret1'
    password_confirmation 'secret1'
  end

  factory :reading do
    # association :author, factory: :user
    title { generate(:reading_title) }
    blood_sugar '5'
    # activation_code { User.generate_activation_code }
    # date_of_birth   { 21.years.ago }
  end

  # factory :old_reading, parent: :reading do
  #   created_at 10.days.ago
  # end

end

# # Returns a User instance that's not saved
# user = build(:user)

# # Returns a saved User instance
# user = create(:user)

# # Returns a hash of attributes that can be used to build a User instance
# attrs = attributes_for(:user)

# # Returns an object with all defined attributes stubbed out
# stub = build_stubbed(:user)

# # Passing a block to any of the methods above will yield the return object
# create(:user) do |user|
#   user.posts.create(attributes_for(:post))
# end

# # Build a User instance and override the first_name property
# user = build(:user, first_name: "Joe")
# user.first_name
# # => "Joe"