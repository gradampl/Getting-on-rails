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
class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence: true,
                    length: { minimum: 4, maximum: 40 }
  validates :text, presence: true,
                   length: { minimum: 5, maximum: 300 }
  validates :user_id, presence: true
end
