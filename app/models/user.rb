# frozen_string_literal: true

class User < ApplicationRecord
  include Discard::Model
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  validates :email, uniqueness: true, presence: true, length: { maximum: 50 },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6, maximum: 20 }, on: :create
  validates :nickname, presence: true, length: { maximum: 50 }
  validates :first_name, length: { maximum: 30 }
  validates :last_name, length: { maximum: 40 }

  default_scope -> { kept }

  def active_for_authentication?
    super && !discarded?
  end
end
