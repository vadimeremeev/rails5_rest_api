object false

node (:users) do
  @users.collect do |user|
    partial 'api/v1/users/show', object: user
  end
end

node (:current_user) do
  {
    id: current_user.try(:id),
    email: current_user.try(:email),
    admin: current_user.try(:is_admin)
  }
end
