module Brickwall
  module API
    class Subscription

      def self.create(params = {})
        response = RestClient.post API.url('subscription'), params, {
          'X-ApiKey' => Brickwall.configuration.brick_private_key
        }
        JSON.parse response
      rescue RestClient::Exception => e
        err = JSON.parse e.response
        Error.new err['type'], err['error'], err['code']
      end

      def self.get(subscription_id)
        response = RestClient.get API.url("subscription/#{subscription_id}"), {
          'X-ApiKey' => Brickwall.configuration.brick_private_key
        }
        JSON.parse response
      end

      def self.cancel(subscription_id)
        response = RestClient.post API.url("subscription/#{subscription_id}/cancel"), {}, {
          'X-ApiKey' => Brickwall.configuration.brick_private_key
        }
        JSON.parse response
      end

    end
  end
end
