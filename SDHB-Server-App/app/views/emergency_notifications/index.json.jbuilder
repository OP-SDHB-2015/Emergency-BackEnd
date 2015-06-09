json.array!(@emergency_notifications) do |emergency_notification|
  json.extract! emergency_notification, :id, :title, :message
  json.url emergency_notification_url(emergency_notification, format: :json)
end
