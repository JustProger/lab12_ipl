# frozen_string_literal: true

class User < ApplicationRecord
  has_many :calcs

  has_secure_password

  def update_last_login_at
    self.last_login_at = DateTime.now
    save
  end
end
