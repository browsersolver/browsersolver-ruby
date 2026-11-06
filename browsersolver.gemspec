# frozen_string_literal: true

require_relative "lib/browsersolver/version"

Gem::Specification.new do |spec|
  spec.name = "browsersolver"
  spec.version = BrowserSolver::VERSION
  spec.authors = ["BrowserSolver"]
  spec.email = ["contact@browsersolver.com"]

  spec.summary = "Official Ruby SDK for the BrowserSolver web unlocker API."
  spec.description = "Unlock, render, crawl and screenshot any website — anti-bot bypass and technology detection through one API."
  spec.homepage = "https://www.browsersolver.com"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/browsersolver/browsersolver-ruby/issues",
    "documentation_uri" => "https://app.browsersolver.com/openapi",
    "homepage_uri" => spec.homepage,
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/browsersolver/browsersolver-ruby"
  }

  spec.files = Dir["LICENSE", "README.md", "examples/**/*", "lib/**/*.rb", "sig/**/*.rbs"]
  spec.require_paths = ["lib"]
end
