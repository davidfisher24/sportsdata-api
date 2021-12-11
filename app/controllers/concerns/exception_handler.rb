module ExceptionHandler
  extend ActiveSupport::Concern

  class NotFoundError < StandardError
    attr_reader :code
    def initialize(code = 404, msg="Not found", exception_type="custom")
      @exception_type = exception_type
      @code = code
      super(msg)
    end
  end

  included do
    rescue_from NotFoundError do |e|
      render json: { error: e.message }, status: :not_found
    end
  end
end
