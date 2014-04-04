require 'asin'
ASIN::Configuration.configure do |config|
  config.secret         = ''
  config.key            = ''
  config.associate_tag  = ''
  config.version  = ''
end

ASIN::Configuration.configure do |config|
 # config.secret         = ENV['ASIN_SECRET']
 # config.key            = ENV['ASIN_KEY']
 # config.associate_tag  = ENV['ASIN_TAG']
end

require 'httpi'
HTTPI.adapter = :httpclient
HTTPI.logger  = Rails.logger
