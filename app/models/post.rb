class Post < ApplicationRecord
  # Associations
  belongs_to :user # Each post belongs to a user (author)
  has_many :comments, dependent: :destroy # A post can have many comments

  # Validations
  validates :title, presence: true
  validates :body, presence: true
  validates :tags, presence: true # Ensures that each post has at least one tag

  # Callbacks
  after_create :schedule_deletion

  private

  # This method schedules the deletion of the post after 24 hours
  def schedule_deletion
    DeletePostJob.set(wait: 24.hours).perform_later(self.id)
  end
end
