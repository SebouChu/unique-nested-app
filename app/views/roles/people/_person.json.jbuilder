json.extract! involvement, :id, :position, :created_at, :updated_at
json.url role_people_url(role, involvement, format: :json)
json.person do
  json.partial! "people/person", person: involvement.person
end
