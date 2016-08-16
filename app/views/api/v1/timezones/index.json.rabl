object false

node (:timezones) do
  @timezones.collect do |zone|
    partial 'api/v1/timezones/show', object: zone
  end
end

node (:current_user) do
  {
    :id => current_user.id,
    :email => current_user.email
  }
end
