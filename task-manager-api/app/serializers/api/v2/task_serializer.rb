class Api::V2::TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :done, :deadline, :created_at,
             :updated_at, :user_id, :short_description

  def short_description
    object.description.truncate(40) if object.description.present?
  end

  def is_late
    Time.current > object.deadline if object.deadline.present?
  end

  belongs_to :user
end
