# frozen_string_literal: true

require "browsersolver"

client = BrowserSolver::Client.new # reads BROWSERSOLVER_API_KEY
response = client.website_screenshot(url: "https://example.com", format: "png")
if response.binary?
  response.save("screenshot.png")
  puts "Saved screenshot.png (#{response.content_type}, #{response.bytes.bytesize} bytes)"
else
  puts response.data
end
