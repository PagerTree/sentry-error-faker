require 'sentry-ruby'
require 'faker'

Sentry.init do |config|
  config.breadcrumbs_logger = [:sentry_logger, :http_logger]

  # To activate performance monitoring, set one of these options.
  # We recommend adjusting the value in production:
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |context|
    0.5
  end
end

cve = Faker::VulnerabilityIdentifier.cve
uuid = SecureRandom.uuid
Sentry.capture_message cve, level: :error, fingerprint: [uuid]
puts "Event sent to Sentry - #{cve}, UUID: #{uuid}"