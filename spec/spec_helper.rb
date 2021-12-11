# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|

  require 'webmock/rspec'

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:each) do
    redis_instance = MockRedis.new
    Redis.stub(:new).and_return(redis_instance)
  end

  config.before(:each) do
    api_response = file_fixture("api_response.json").read
    stub_request(:get, "http://api.scraperapi.com?api_key=#{ENV['scraper_api_key']}&country_code=uk&url=https://m.betvictor.com/bv_in_play/v2/en-gb/1/mini_inplay.json").
    to_return(status: 200, body: api_response)
  end

end
