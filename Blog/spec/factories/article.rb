# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    title { "test_title" }
    text { "test_text" }
    user { User.last }
  end
end
