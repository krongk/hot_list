json.array!(@lists) do |list|
  json.extract! list, :id, :title, :short_title
  json.url list_url(list, format: :json)
end
