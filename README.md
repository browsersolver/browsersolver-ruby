# BrowserSolver Ruby SDK

The official Ruby SDK for the [BrowserSolver](https://www.browsersolver.com) web unlocker API.

Unlock, render, crawl and screenshot any website — anti-bot bypass and technology detection through one API.

The SDK exposes **9 methods**, one per documented endpoint, plus a generic `request`. It only uses the Ruby standard library.

## Requirements

- Ruby 3.1 or newer

## Installation

```sh
gem install browsersolver
```

Or in your `Gemfile`:

```ruby
gem "browsersolver"
```

## Get your API key

[Sign up for BrowserSolver](https://app.browsersolver.com/register) or sign in, then copy your API key from the [dashboard](https://app.browsersolver.com). The client reads `ENV["BROWSERSOLVER_API_KEY"]` when no key is passed.

## Quick start

```ruby
require "browsersolver"

client = BrowserSolver::Client.new(api_key: ENV.fetch("BROWSERSOLVER_API_KEY"))
response = client.website_webunlocker(query: "https://example.com")
puts response.data
```

Keyword arguments use the parameter names of the [API reference](https://app.browsersolver.com/openapi). Unknown names raise `BrowserSolver::SerializationError`; use `request` for undocumented parameters.

## Binary responses

Endpoints that can return a file (image, PDF…) return a `JsonResponse` or a `BinaryResponse`:

```ruby
response = client.website_screenshot(url: "https://example.com", format: "png")
response.save("screenshot.png") if response.binary?
```

## Async jobs

Any call accepts `is_async: true` (useful past the 60-second server limit): the response is then a `job_id`. `wait_for_job` polls `GET /v1/jobs/{id}` until a terminal status (`CompletedJob`, `Error`, `NotFound`, `BadRequest`):

```ruby
submitted = client.website_webunlocker(query: "https://example.com", is_async: true)
job = client.wait_for_job(submitted.data["job_id"]) { |j| puts "#{j['status']} #{j['progress']}%" }
puts job.data
```

## GET or POST

Methods use GET when the endpoint supports it (query string). POST sends the same parameters as JSON:

```ruby
client.website_crawler(query: "https://books.toscrape.com/", request_options: { method: "POST" })
```

`nil` values are omitted, `false` and `0` are sent, and arrays repeat the parameter name.

## Any endpoint

```ruby
response = client.request("GET", "/v1/usage")
```

## Errors

```ruby
begin
  client.website_webunlocker(query: "https://example.com")
rescue BrowserSolver::APIError => e
  warn "HTTP #{e.status}: #{e.message}"
end
```

| Error | When |
| --- | --- |
| `BrowserSolver::ConfigurationError` | Missing API key, invalid options or unsupported method. |
| `BrowserSolver::SerializationError` | A required parameter is missing, unknown or can't be sent. |
| `BrowserSolver::TransportError` | Network failure or timeout. |
| `BrowserSolver::APIError` | Non-2xx status (`status`, `error_message`, `response_body`, `raw_response`). |
| `BrowserSolver::ResponseDecodingError` | A success response could not be decoded. |

All of them inherit from `BrowserSolver::Error`.

## Retries

Requests are retried up to 3 times after a network error, a `408`, `500`, `502`, `503` or `504`, or a rate limit — which the API returns as `401` (or `429`) with a `Rate limit exceeded` message. Per-key quota errors (`…: quota daily`) are not retried, nor are `400`, `402`, `404` or client-side timeouts. The delay starts at 1 second and grows 1.5× per retry (capped at 30 seconds); a `Retry-After` header wins.

```ruby
client = BrowserSolver::Client.new(max_retries: 5, retry_delay: 0.5)
client.website_webunlocker(query: "https://example.com", request_options: { max_retries: 0 }) # one request without retries
```

## Batch requests

`batch` runs the block for every item on 10 threads (`concurrency:`) and returns one `BatchResult` per item, in input order. A failing item never stops the others.

```ruby
inputs = ["https://example.com", "https://www.browsersolver.com"]
results = client.batch(inputs, concurrency: 5) { |value| client.website_webunlocker(query: value) }
results.each do |result|
  if result.ok?
    puts result.value.data
  else
    warn "#{inputs[result.index]}: #{result.error.message}"
  end
end
```

| Constant | Default | Description |
| --- | --- | --- |
| `BrowserSolver::Client::DEFAULT_CONCURRENCY` | `10` | Tasks run at the same time by batch |
| `BrowserSolver::Client::DEFAULT_TIMEOUT` | `120` | Request timeout (seconds) |
| `BrowserSolver::Client::MAX_RETRIES` | `3` | Retry attempts after a network error, a 408/5xx or a rate limit |
| `BrowserSolver::Client::RETRY_BACKOFF_FACTOR` | `1.5` | Exponential backoff multiplier |
| `BrowserSolver::Client::DEFAULT_RETRY_DELAY` | `1.0` | Delay before the first retry (seconds) |

## Timeouts and custom transports

```ruby
client = BrowserSolver::Client.new(timeout: 60) # seconds, default 120
client.website_webunlocker(query: "https://example.com", request_options: { timeout: 30 })
```

A transport is any object with `call(method:, url:, headers:, body:, timeout:)` returning `[status, headers, body]`; the default is `BrowserSolver::NetHTTPTransport`.

## Endpoints

9 methods, generated from the [OpenAPI document](https://app.browsersolver.com/openapi).

| Method | HTTP | Description |
| --- | --- | --- |
| `jobs` | GET `/v1/jobs/{id}` | Poll the status, progress (0–100) and result of a job started with is_async=true. Polling is free. Poll until status is terminal: Completed… |
| `stats` | GET `/v1/stats` | Infrastructure health for an engine or endpoint over the last hour. Not scoped to your account or tenant. Enabled per account: HTTP 403 mea… |
| `usage` | GET `/v1/usage` | Retrieve real-time usage statistics and credit balance for your BrowserSolver account. |
| `website_antibot` | GET `/v1/website/antibot` | Single-pass scan that names the bot-protection vendor in front of a URL so you can choose the right BrowserSolver fetch tier next. |
| `website_crawler` | GET / POST `/v1/website/crawler` | Fast HTTP pull of public HTML with no browser session. Ideal when the first response already contains the content you need. |
| `website_rendering` | GET `/v1/website/rendering` | Run a managed browser session against a public URL and collect the HTML after client-side scripts finish. Prefer Crawler for static markup;… |
| `website_screenshot` | GET / POST `/v1/website/screenshot` | Turn any public URL into a PNG, JPEG, WebP, or PDF asset rendered by BrowserSolver. No local Chromium fleet to operate. |
| `website_technology` | GET / POST `/v1/website/technology` | Map CMS, frameworks, analytics, CDN, and security tooling exposed by a public URL. Choose simple lists or expert metadata with confidence s… |
| `website_webunlocker` | GET / POST `/v1/website/webunlocker` | BrowserSolver's highest HTML fetch tier for retail and marketplace hosts on your account whitelist. Solves persistent bot challenges that s… |

## All BrowserSolver SDKs

| SDK | Package | Install |
| --- | --- | --- |
| Node.js | [`@browsersolver/sdk`](https://www.npmjs.com/package/@browsersolver/sdk) | `npm install @browsersolver/sdk` |
| Python | [`browsersolver`](https://pypi.org/project/browsersolver/) | `pip install browsersolver` |
| Go | [`browsersolver-go`](https://pkg.go.dev/github.com/browsersolver/browsersolver-go) | `go get github.com/browsersolver/browsersolver-go` |
| .NET | [`BrowserSolver`](https://www.nuget.org/packages/BrowserSolver) | `dotnet add package BrowserSolver` |
| Ruby | [`browsersolver`](https://rubygems.org/gems/browsersolver) | `gem install browsersolver` |
| PHP | [`browsersolver/sdk`](https://packagist.org/packages/browsersolver/sdk) | `composer require browsersolver/sdk` |
| Java | [`browsersolver-java`](https://github.com/browsersolver/browsersolver-java) | build from source, see its README |
| CLI | [`@browsersolver/cli`](https://www.npmjs.com/package/@browsersolver/cli) | `npm install -g @browsersolver/cli` |
| MCP server | [`@browsersolver/mcp`](https://www.npmjs.com/package/@browsersolver/mcp) | `npx -y @browsersolver/mcp` |

## License

MIT — see [LICENSE](LICENSE).
