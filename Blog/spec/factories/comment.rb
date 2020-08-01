# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    commenter { "test_commenter" }
    body { "test_body" }
  end
end
