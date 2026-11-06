# frozen_string_literal: true

# Generated from the BrowserSolver OpenAPI document. Do not edit by hand.

module BrowserSolver
  # One method per documented endpoint. Mixed into {Client}.
  module Operations
    # Jobs. Poll the status, progress (0–100) and result of a job started with is_async=true. Polling is free. Poll until status is terminal: CompletedJob, Error, NotFound or BadRequest.
    #
    # +GET /v1/jobs/{id}+
    #
    # @param id [String] (required) The job_id returned by an endpoint called with is_async=true.
    # @param request_options [Hash, nil] +:method+ ("GET"/"POST"), +:timeout+ (seconds), +:headers+
    # @return [JsonResponse]
    def jobs(request_options: nil, **params)
      call_operation("jobs", params, request_options)
    end

    # Stats. Infrastructure health for an engine or endpoint over the last hour. Not scoped to your account or tenant. Enabled per account: HTTP 403 means contact support to activate it.
    #
    # +GET /v1/stats+
    #
    # @param engine [String] API family to check, for example website. Provide at least engine or path.
    # @param path [String] Specific endpoint to check, for example /v1/website/screenshot. If you also pass engine, use an endpoint from that API.
    # @param request_options [Hash, nil] +:method+ ("GET"/"POST"), +:timeout+ (seconds), +:headers+
    # @return [JsonResponse]
    def stats(request_options: nil, **params)
      call_operation("stats", params, request_options)
    end

    # Usage. Retrieve real-time usage statistics and credit balance for your BrowserSolver account.
    #
    # +GET /v1/usage+
    #
    # @param request_options [Hash, nil] +:method+ ("GET"/"POST"), +:timeout+ (seconds), +:headers+
    # @return [JsonResponse]
    def usage(request_options: nil, **params)
      call_operation("usage", params, request_options)
    end

    # Website Antibot. Single-pass scan that names the bot-protection vendor in front of a URL so you can choose the right BrowserSolver fetch tier next. Credit cost: 1 credit per call.
    #
    # +GET /v1/website/antibot+
    #
    # @param query [String] (required) Full URL or bare domain to scan for bot-protection vendors.
    # @param timeout [Numeric] Upper bound for waiting on the target HTTP response, expressed in seconds (defaults to 15).
    # @param fields [String] Comma-separated list of fields to keep in the response, with dot notation for nested fields (e.g. name,location.city). Does not change the credit cost.
    # @param is_async [Boolean] Process the request asynchronously: the response is a job_id to poll on /v1/jobs/{id} (see waitForJob).
    # @param soft_fail [Boolean] Return HTTP 200 even when an error occurs; the error is then in the response body.
    # @param request_options [Hash, nil] +:method+ ("GET"/"POST"), +:timeout+ (seconds), +:headers+
    # @return [JsonResponse]
    def website_antibot(request_options: nil, **params)
      call_operation("website_antibot", params, request_options)
    end

    # Website Crawler. Fast HTTP pull of public HTML with no browser session. Ideal when the first response already contains the content you need. Credit cost: 1 credit per call.
    #
    # +GET / POST /v1/website/crawler+
    #
    # @param query [String] (required) Public URL to retrieve with the Crawler tier (plain HTTP, no JavaScript). Include http:// or https://.
    # @param allow_redirects [Boolean] Whether BrowserSolver should chase HTTP redirects for this fetch.
    # @param return_page_source [Boolean] Choose between processed markup and the exact bytes from the origin.
    # @param fields [String] Comma-separated list of fields to keep in the response, with dot notation for nested fields (e.g. name,location.city). Does not change the credit cost.
    # @param is_async [Boolean] Process the request asynchronously: the response is a job_id to poll on /v1/jobs/{id} (see waitForJob).
    # @param soft_fail [Boolean] Return HTTP 200 even when an error occurs; the error is then in the response body.
    # @param request_options [Hash, nil] +:method+ ("GET"/"POST"), +:timeout+ (seconds), +:headers+
    # @return [JsonResponse]
    def website_crawler(request_options: nil, **params)
      call_operation("website_crawler", params, request_options)
    end

    # Website Rendering. Run a managed browser session against a public URL and collect the HTML after client-side scripts finish. Prefer Crawler for static markup; escalate to WebUnlocker on approved hosts when challenges persist. Credit cost: 2 credits per call.
    #
    # +GET /v1/website/rendering+
    #
    # @param query [String] (required) Public URL to load inside BrowserSolver's headless browser. Include http:// or https://.
    # @param wait_in_seconds [Numeric] Extra pause, in seconds, after the page load event before BrowserSolver returns HTML. Helpful when widgets animate or hydrate late.
    # @param wait_for [String] CSS or XPath selector that must appear in the DOM before HTML is returned. The managed browser waits until the node exists (or until timeout).
    # @param block_ads [Boolean] Skip ad-network requests while the page renders.
    # @param timeout [Numeric] Hard ceiling, in seconds, for the render session. When reached, BrowserSolver returns whatever HTML is available.
    # @param fields [String] Comma-separated list of fields to keep in the response, with dot notation for nested fields (e.g. name,location.city). Does not change the credit cost.
    # @param is_async [Boolean] Process the request asynchronously: the response is a job_id to poll on /v1/jobs/{id} (see waitForJob).
    # @param soft_fail [Boolean] Return HTTP 200 even when an error occurs; the error is then in the response body.
    # @param request_options [Hash, nil] +:method+ ("GET"/"POST"), +:timeout+ (seconds), +:headers+
    # @return [JsonResponse]
    def website_rendering(request_options: nil, **params)
      call_operation("website_rendering", params, request_options)
    end

    # Website Screenshot. Turn any public URL into a PNG, JPEG, WebP, or PDF asset rendered by BrowserSolver. No local Chromium fleet to operate. Credit cost: 2 credits per call.
    #
    # +GET / POST /v1/website/screenshot+
    #
    # @param url [String] (required) Page address to render into an image or PDF. Must include a protocol.
    # @param format [String] File type returned in the response body.
    # @param device [String] Swap the desktop viewport for a preset handset or tablet fingerprint.
    # @param full_page [Boolean] Extend the capture beyond the viewport so the entire scrollable document is included.
    # @param full_page_scroll [Boolean] Drive a scroll pass first so deferred content mounts before a tall capture.
    # @param full_page_scroll_duration [Numeric] Milliseconds spent scrolling prior to a full-height capture.
    # @param viewport_width [Numeric] Width of the synthetic desktop window, in pixels.
    # @param viewport_height [Numeric] Height of the synthetic desktop window, in pixels.
    # @param scale_factor [Numeric] Pixel density multiplier. Raise it for retina-quality output; files grow accordingly.
    # @param image_quality [String] Lossy compression level for soft formats.
    # @param selector [String] Limit the shot to one DOM node matched by this CSS selector.
    # @param cache [Boolean] Serve a stored capture on repeat requests when caching is enabled.
    # @param cache_ttl [Numeric] Lifetime of cached captures in seconds.
    # @param remove_selectors [String] Hide matching CSS selectors (modals, promo bars, etc.) before shooting.
    # @param remove_cookie_banners [Boolean] Best-effort removal of cookie consent layers before capture.
    # @param remove_ads [Boolean] Best-effort stripping of ad slots before capture.
    # @param block_resources [String] Resource kinds to discard during load, as a comma list (example: image,stylesheet,font).
    # @param block_urls [String] Substring patterns that should never be fetched (example: analytics,tracking,advertisement). Hosts, paths, or fragments such as .example.com/ work.
    # @param delay [Numeric] Additional settle time in seconds after the readiness event.
    # @param wait_until [Array<String>] Which browser lifecycle event marks the page ready.
    # @param wait_for_selector [String] Hold capture until this CSS node is present.
    # @param proxy [String] Route the browser through an intermediate proxy.
    # @param s3_secret_key [String] Secret key used to authenticate uploads.
    # @param s3_access_key_id [String] Access key used to authenticate uploads.
    # @param s3_bucket [String] Destination bucket for the binary asset.
    # @param s3_object_key [String] Key under which the object is stored (generated automatically if blank).
    # @param s3_region [String] Cloud region of the bucket.
    # @param storage_endpoint [String] Override the default AWS endpoint for S3-compatible backends. Leave blank for AWS. R2 example: https://<accountId>.r2.cloudflarestorage.com.
    # @param s3_url [Boolean] Upload the binary and include the public object URL in the API response.
    # @param fields [String] Comma-separated list of fields to keep in the response, with dot notation for nested fields (e.g. name,location.city). Does not change the credit cost.
    # @param is_async [Boolean] Process the request asynchronously: the response is a job_id to poll on /v1/jobs/{id} (see waitForJob).
    # @param soft_fail [Boolean] Return HTTP 200 even when an error occurs; the error is then in the response body.
    # @param request_options [Hash, nil] +:method+ ("GET"/"POST"), +:timeout+ (seconds), +:headers+
    # @return [JsonResponse, BinaryResponse]
    def website_screenshot(request_options: nil, **params)
      call_operation("website_screenshot", params, request_options)
    end

    # Website Technology. Map CMS, frameworks, analytics, CDN, and security tooling exposed by a public URL. Choose simple lists or expert metadata with confidence scores. Credit cost: 1 credit per call.
    #
    # +GET / POST /v1/website/technology+
    #
    # @param query [String] (required) Public URL to fingerprint for CMS, frameworks, analytics, CDN, and security tooling. Include http:// or https://.
    # @param mode [String] How much detail to include in the stack report.
    # @param fields [String] Comma-separated list of fields to keep in the response, with dot notation for nested fields (e.g. name,location.city). Does not change the credit cost.
    # @param is_async [Boolean] Process the request asynchronously: the response is a job_id to poll on /v1/jobs/{id} (see waitForJob).
    # @param soft_fail [Boolean] Return HTTP 200 even when an error occurs; the error is then in the response body.
    # @param request_options [Hash, nil] +:method+ ("GET"/"POST"), +:timeout+ (seconds), +:headers+
    # @return [JsonResponse]
    def website_technology(request_options: nil, **params)
      call_operation("website_technology", params, request_options)
    end

    # Website WebUnlocker. BrowserSolver's highest HTML fetch tier for retail and marketplace hosts on your account whitelist. Solves persistent bot challenges that still block Rendering. Credit cost: 3 credits per call.
    #
    # +GET / POST /v1/website/webunlocker+
    #
    # @param query [String] (required) Public URL to fetch with the WebUnlocker tier. Include http:// or https://. The hostname must be on your BrowserSolver whitelist.
    # @param allow_redirects [Boolean] Whether the unlock session should chase HTTP redirects.
    # @param return_page_source [Boolean] Choose between processed markup and the exact post-unlock source.
    # @param fields [String] Comma-separated list of fields to keep in the response, with dot notation for nested fields (e.g. name,location.city). Does not change the credit cost.
    # @param is_async [Boolean] Process the request asynchronously: the response is a job_id to poll on /v1/jobs/{id} (see waitForJob).
    # @param soft_fail [Boolean] Return HTTP 200 even when an error occurs; the error is then in the response body.
    # @param request_options [Hash, nil] +:method+ ("GET"/"POST"), +:timeout+ (seconds), +:headers+
    # @return [JsonResponse]
    def website_webunlocker(request_options: nil, **params)
      call_operation("website_webunlocker", params, request_options)
    end
  end
end
