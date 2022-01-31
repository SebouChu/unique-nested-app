json.extract! person, :id, :first_name, :last_name, :biography, :created_at, :updated_at
json.url person_url(person, format: :json)
json.biography person.biography.to_s
