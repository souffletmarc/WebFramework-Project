json.array!(@users) do |user|
  json.extract! user, :id, :id, :firstname, :lastname, :email, :password, :salt
  json.url user_url(user, format: :json)
end
