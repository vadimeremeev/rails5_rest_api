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


node (:total_pages) { @users.try(:total_pages) || 0 }
node (:current_page) { @users.try(:current_page) || 1 }
node (:per_page) { (params[:size] || 10).to_i }
node (:total_results) { @users.try(:total_count)|| 0 }