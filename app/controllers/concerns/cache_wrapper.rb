module CacheWrapper

  require 'redis'

  def cache_fetch(key, exp = 300)
    redis = Redis.new(host: "localhost")

    cache_data = redis.get(key)
    if cache_data
      return JSON.parse cache_data
    end

    request_data = yield()
    redis.setex(key, exp, request_data.to_json)
    return request_data

  end
end



