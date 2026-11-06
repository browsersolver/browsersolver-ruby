# frozen_string_literal: true

require "browsersolver"

client = BrowserSolver::Client.new # reads BROWSERSOLVER_API_KEY
begin
  response = client.request("GET", "/v1/usage")
  puts response.data if response.json?
rescue BrowserSolver::APIError => e
  warn "HTTP #{e.status}: #{e.message}"
end
