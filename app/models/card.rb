class Card < ApplicationRecord
	belongs_to :user
  belongs_to :list
  has_many :comments, as: :commentable
  scope :find_user_cards, -> (id) {joins(:list).merge(List.joins(:users).where("users.id = #{id} ")).uniq}
end
