class User < ApplicationRecord
  has_many  :articles, dependent: :destroy
  has_many  :books, dependent: :destroy
  # has_many  :comments, dependent :destroy

  # after_create_commit :log_user_saved_to_db
  # after_update_commit :log_user_saved_to_db
  #
  # private
  # def log_user_saved_to_db
  #   puts 'User was saved to 1database'
  # end

  before_save {self.email = email.downcase }
  validates :username, presence: true,
            uniqueness: {case_sensitive: false},
            length: {minimum: 3 }

  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email,presence: true,
            uniqueness: {case_sensitive: false}
            # format: {with: VALID_EMAIL_REGEX}
  has_secure_password
end