# frozen_string_literal: true

class AddUserToCalcs < ActiveRecord::Migration[7.0]
  def change
    add_reference :calcs, :user, null: true, foreign_key: true
  end
end
