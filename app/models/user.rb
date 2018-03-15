class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
devise :database_authenticatable, :encryptable

validates :first_name, :last_name, :email, presence: true
has_many :recipes
has_many :notifications, dependent: :destroy
has_many :friendships, dependent: :destroy
has_many :comments, dependent: :destroy
has_many :likes, dependent: :destroy
has_many :friends, -> { where("status = 'accepted'") }, through: :friendships
has_many :requested_friends, -> { where("status = 'requested'") }, source: :friend
has_many :pending_friends, -> { where("status = 'pending") }, through: :friendship, source: :friend


def change
    add_column :users, :password_salt, :string
end

end
