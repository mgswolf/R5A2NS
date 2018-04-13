class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  validates :auth_token, uniqueness: true
  before_create :generate_auth_token!

  has_many :tasks, dependent: :destroy

  def info
    "#{email} - #{created_at} - Token: #{auth_token}"
  end

  def generate_auth_token!
    loop do
      self.auth_token = Devise.friendly_token
      break unless User.exists?(auth_token: auth_token)
    end
  end
end
