json.extract! course, :id, :prefix, :number, :description, :created_at, :updated_at
json.url course_url(course, format: :json)
