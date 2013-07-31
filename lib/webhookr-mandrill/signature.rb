require "securecompare"
require "openssl"

module Webhookr
  module Mandrill
    class Signature
      attr_reader :request, :key

      def initialize(request, key)
        @request = request
        @key = key
      end

      def valid?
        SecureCompare.compare(request_signature, generated_signature)
      end

      private

      def request_signature
        request.headers['X-Mandrill-Signature']
      end

      def generated_signature
        data = request.url
        request.params.except(:action, :controller, :format).keys.sort.each do |key|
          data << key.to_s << request.params[key]
        end
        Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha1'), key, data)).rstrip
      end
    end
  end
end
