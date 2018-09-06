class Article < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :comments , dependent: :destroy
  validates :title, presence: true , length: {minimum: 5,maximum: 100}
  validates :user_id, presence: true
end
