# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  text       :text(65535)
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
