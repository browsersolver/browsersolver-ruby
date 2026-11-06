# frozen_string_literal: true

require "browsersolver"

client = BrowserSolver::Client.new # reads BROWSERSOLVER_API_KEY
submitted = client.website_webunlocker(query: "https://example.com", is_async: true)
job = client.wait_for_job(submitted.data["job_id"]) { |j| puts "#{j['status']} #{j['progress']}%" }
puts job.data
