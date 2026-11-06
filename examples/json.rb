# frozen_string_literal: true

require "json"
require "browsersolver"

client = BrowserSolver::Client.new # reads BROWSERSOLVER_API_KEY
response = client.website_webunlocker(query: "https://example.com")
puts JSON.pretty_generate(response.data)
