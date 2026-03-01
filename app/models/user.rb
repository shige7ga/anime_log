class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password, confirmation: true

  has_many :posts

  has_secure_password
end
