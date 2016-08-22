class User < ApplicationRecord
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  default_scope { order("id DESC")}

  scope :search, ->(q) { where("LOWER(name) LIKE :q OR LOWER(email) LIKE :q", q: "%#{q.to_s.downcase}%") }

end
