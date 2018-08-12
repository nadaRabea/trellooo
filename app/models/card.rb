class Card < ApplicationRecord
	belongs_to :user
  belongs_to :list
  has_many :comments, -> { limit(3) } , as: :commentable
  scope :find_user_cards, -> (id) {joins(:list).merge(List.joins(:users).where("users.id = #{id} ")).uniq}
  scope :order_cards_by_comments, -> {select("cards.*, COUNT(comments.id) as comment_count").joins("LEFT OUTER JOIN users ON users.id = cards.user_id LEFT OUTER JOIN comments ON comments.user_id = users.id").group("cards.id").order("comment_count DESC")}
end