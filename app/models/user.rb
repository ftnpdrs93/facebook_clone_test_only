class User < ActiveRecord::Base
	has_secure_password
	validates :name, presence: true
	validates :email, presence: true, uniqueness: true
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
	validates :password, length: { in: 6..20 }
	validates :password_confirmation, presence: true
	has_many :statuses, dependent: :destroy
	has_many :likes, dependent: :destroy
end
