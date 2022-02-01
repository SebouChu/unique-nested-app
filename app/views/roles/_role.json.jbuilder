json.extract! role, :id, :position, :created_at, :updated_at
json.url role_url(role, format: :json)
json.description role.description.to_s
