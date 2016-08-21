class Timezone < ApplicationRecord
  belongs_to :user

  delegate :email, to: :user, allow_nil: true
  delegate :is_admin, to: :user, allow_nil: true

  scope :filtered_by_user, ->(user) { where(user_id: user.try(:id)) unless user.try(:is_admin) }

  scope :search, ->(q) { where("LOWER(name) LIKE :q OR LOWER(city) LIKE :q", q: "%#{q.to_s.downcase}%") }
end
