module ProxyRequest
  
  require 'rest-client'

  def proxy_request(request_url)
    proxy_service = "http://api.scraperapi.com"
    proxy_location = "uk"
    api_key = ENV['scraper_api_key']
    puts api_key
    url = "#{proxy_service}?api_key=#{api_key}&country_code=#{proxy_location}&url=#{request_url}"
    response = RestClient.get(url)
    JSON.parse response
  end
end