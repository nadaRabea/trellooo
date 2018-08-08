class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  enum role: [:admin, :member]

  has_many :created_lists, class_name: 'List', dependent: :destroy, foreign_key: 'creator_id'
  has_and_belongs_to_many :lists
  has_many :cards, dependent: :destroy
end
