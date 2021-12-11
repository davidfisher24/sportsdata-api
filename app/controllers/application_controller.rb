class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  include ProxyRequest
  include CacheWrapper
end
