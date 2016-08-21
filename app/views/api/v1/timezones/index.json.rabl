object false

node (:timezones) do
  @timezones.collect do |zone|
    partial 'api/v1/timezones/show', object: zone
  end
end

node (:current_user) do
  {
    id: current_user.try(:id),
    email: current_user.try(:email),
    admin: current_user.try(:is_admin)
  }
end

node (:total_pages) { @timezones.try(:total_pages) || 0 }
node (:current_page) { @timezones.try(:current_page) || 1 }
node (:per_page) { (params[:size] || 10).to_i }
node (:total_results) { @timezones.try(:total_count)|| 0 }