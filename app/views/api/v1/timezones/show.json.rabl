object @timezone

attributes :id
attributes :name
attributes :city
attributes :gmt_offset
node (:owner) do |t|
  {
    id: t.user_id,
    email: t.email
  }
end