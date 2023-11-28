class Comment < ApplicationRecord
  # Associations
  belongs_to :user # Each comment belongs to a user
  belongs_to :post # Each comment belongs to a post

  # Validations
  validates :body, presence: true
end
