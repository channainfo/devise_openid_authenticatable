module DeviseOpenidAuthenticatable
  module Controller
    extend ActiveSupport::Concern

    included do
      alias_method :original_verify_authenticity_token, :verify_authenticity_token
      alias_method :verify_authenticity_token, :openid_response_check
    end

    protected
    def openid_response_check
      original_verify_authenticity_token unless openid_provider_response?
    end

    def openid_provider_response?
      !!request.env[Rack::OpenID::RESPONSE]
    end
  end
end
