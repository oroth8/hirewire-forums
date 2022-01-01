# frozen_string_literal: true

class Discussion < ApplicationRecord
  belongs_to :user, default: -> { Current.user }

  validates :name, presence: true, uniqueness: true

  def to_param
    "#{id}-#{name.downcase.to_s[0...100]}".parameterize
  end
end
