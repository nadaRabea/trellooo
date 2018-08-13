class List < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_and_belongs_to_many :users
  has_many :cards, dependent: :destroy
  scope :find_user_lists, -> (id) { joins(:users).where("users.id = #{id} ")}
end
