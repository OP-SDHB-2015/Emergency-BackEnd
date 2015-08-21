json.array!(@users) do |user|
  json.extract! user, :id, :staffID, :lastName, :firstName, :deviceID, :authenticated, :region, :group
  json.url user_url(user, format: :json)
end
