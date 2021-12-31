# frozen_string_literal: true

class MakeUsernameNotNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:users, :username, false)
    change_column_default(:users, :username, from: nil, to: '')
  end
end
