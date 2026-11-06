# frozen_string_literal: true

# Generated from the BrowserSolver OpenAPI document. Do not edit by hand.

module BrowserSolver
  # Path, methods, response kind and parameter names of every documented operation.
  ENDPOINTS = {
    "jobs" => {
      path: "/v1/jobs/{id}",
      methods: ["GET"].freeze,
      response: :json,
      required: ["id"].freeze,
      params: ["id"].freeze
    }.freeze,
    "stats" => {
      path: "/v1/stats",
      methods: ["GET"].freeze,
      response: :json,
      required: [].freeze,
      params: ["engine", "path"].freeze
    }.freeze,
    "usage" => {
      path: "/v1/usage",
      methods: ["GET"].freeze,
      response: :json,
      required: [].freeze,
      params: [].freeze
    }.freeze,
    "website_antibot" => {
      path: "/v1/website/antibot",
      methods: ["GET"].freeze,
      response: :json,
      required: ["query"].freeze,
      params: ["query", "timeout", "fields", "is_async", "soft_fail"].freeze
    }.freeze,
    "website_crawler" => {
      path: "/v1/website/crawler",
      methods: ["GET", "POST"].freeze,
      response: :json,
      required: ["query"].freeze,
      params: ["query", "allow_redirects", "return_page_source", "fields", "is_async", "soft_fail"].freeze
    }.freeze,
    "website_rendering" => {
      path: "/v1/website/rendering",
      methods: ["GET"].freeze,
      response: :json,
      required: ["query"].freeze,
      params: ["query", "wait_in_seconds", "wait_for", "block_ads", "timeout", "fields", "is_async", "soft_fail"].freeze
    }.freeze,
    "website_screenshot" => {
      path: "/v1/website/screenshot",
      methods: ["GET", "POST"].freeze,
      response: :any,
      required: ["url"].freeze,
      params: ["url", "format", "device", "full_page", "full_page_scroll", "full_page_scroll_duration", "viewport_width", "viewport_height", "scale_factor", "image_quality", "selector", "cache", "cache_ttl", "remove_selectors", "remove_cookie_banners", "remove_ads", "block_resources", "block_urls", "delay", "wait_until", "wait_for_selector", "proxy", "s3_secret_key", "s3_access_key_id", "s3_bucket", "s3_object_key", "s3_region", "storage_endpoint", "s3_url", "fields", "is_async", "soft_fail"].freeze
    }.freeze,
    "website_technology" => {
      path: "/v1/website/technology",
      methods: ["GET", "POST"].freeze,
      response: :json,
      required: ["query"].freeze,
      params: ["query", "mode", "fields", "is_async", "soft_fail"].freeze
    }.freeze,
    "website_webunlocker" => {
      path: "/v1/website/webunlocker",
      methods: ["GET", "POST"].freeze,
      response: :json,
      required: ["query"].freeze,
      params: ["query", "allow_redirects", "return_page_source", "fields", "is_async", "soft_fail"].freeze
    }.freeze
  }.freeze
end
