json.extract! program, :id, :title, :description, :created_at, :updated_at
json.url program_url(program, format: :json)
json.description program.description.to_s
