FactoryGirl.define do
  sequence :reading_title do |n|
    "ReadingTitle#{n}"
  end

  factory :reading do
    association :user_id, factory: :user
    title { generate(:reading_title) }
    blood_sugar '5'

    trait :a_month_ago do
      created_at { 1.month.ago }
    end

  end

end