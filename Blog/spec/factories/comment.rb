# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    # id { 1 }
    commenter { "test_commenter" }
    body { "test_body" }
    # Add additional fields as required via your User model
  end
end
