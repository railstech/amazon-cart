require 'asin'
ASIN::Configuration.configure do |config|
  config.secret         = 'P1Im50TxFQ/rJGdEDNOvIcJUos8ytFpCH5RuLZqP'
  config.key            = 'AKIAJTVK5XI3WHSXV6WA'
  config.associate_tag  = 'twoologyidyll-20!'
  config.version  = '2011-08-01'
end

ASIN::Configuration.configure do |config|
 # config.secret         = ENV['ASIN_SECRET']
 # config.key            = ENV['ASIN_KEY']
 # config.associate_tag  = ENV['ASIN_TAG']
end

require 'httpi'
HTTPI.adapter = :httpclient
HTTPI.logger  = Rails.logger
