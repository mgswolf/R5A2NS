class Task < ApplicationRecord
  belongs_to :user

  validates :user_id, :title, presence: true
end
