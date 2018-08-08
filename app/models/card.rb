class Card < ApplicationRecord
	belongs_to :user
  belongs_to :list
  has_many :comments, as: :commentable
end
