class Timezone < ApplicationRecord
  belongs_to :user

  delegate :email, :to => :user, :allow_nil => true
end
