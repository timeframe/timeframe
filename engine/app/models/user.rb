# frozen_string_literal: true

class User < ActiveRecord::Base
  encrypts :email, deterministic: true

  has_many :account_users, dependent: :destroy
  has_many :accounts, through: :account_users

  validates :email, presence: true, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}
  validate :email_must_not_contain_plus

  private

  def email_must_not_contain_plus
    if email.present? && email.include?("+")
      errors.add(:email, "must not contain +")
    end
  end
end
