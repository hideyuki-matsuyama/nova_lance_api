# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    nickname { Gimei.name }
    password { 'password' }
    jti { SecureRandom.uuid }
  end
end
