# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    # id { 1 }
    title { "test_title" }
    text { "test_text" }
    user { User.last }
    # Add additional fields as required via your User model
  end
end
