json.array!(@landing_pages) do |landing_page|
  json.extract! landing_page, :id
  json.url landing_page_url(landing_page, format: :json)
end
