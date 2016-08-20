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
