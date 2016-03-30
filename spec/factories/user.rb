# This will guess the User class
FactoryGirl.define do
  sequence :email do |n|
    "fakeuser#{n}@example.com"
  end

  sequence :id do |n|
    n
  end

  factory :user do
    id { generate(:id) }
    email { generate(:email) }
    password  'secret1'
    password_confirmation 'secret1'

    factory :user_with_readings do
      after(:create) do |user|
        create_list(:reading, 3, user: user)
      end
    end

    factory :user_with_many_readings do
      after(:create) do |user|
        create_list(:reading, 10, user: user)
      end
    end

    factory :user_with_many_readings_created_from_all_dates do
      after(:create) do |user|
        create_list(:reading, 2, { user: user, created_at: Time.now, title: 'now' })
        create_list(:reading, 2, { user: user, created_at: 1.days.ago, title: '1daysago' })
        create_list(:reading, 2, { user: user, created_at: 1.week.ago, title: '1weekago' })
        create_list(:reading, 2, { user: user, created_at: 1.month.ago, title: '1monthago' })
        create_list(:reading, 2, { user: user, created_at: 3.months.ago, title: '3monthsago' })
      end
    end

  end

end
