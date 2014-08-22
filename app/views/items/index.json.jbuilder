json.array!(@items) do |item|
  json.extract! item, :id, :list_id, :title, :url, :summary
  json.url item_url(item, format: :json)
end
