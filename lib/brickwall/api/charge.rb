module Brickwall
  module API
    module Charge
      def self.create(params = {})
        api_params = params
        if api_params.has_key?('browser_ip') && !api_params.has_key?('browser_domain')
          api_params = params.clone
          api_params['browser_domain'] = Brickwall.configuration.application_domain
        end
        response = RestClient.post API.url('charge'), api_params, {
          'X-ApiKey' => Brickwall.configuration.brick_private_key
        }
        JSON.parse response
      rescue RestClient::Exception => e
        err = JSON.parse e.response
        Error.new err['type'], err['error'], err['code']
      end

      def self.get(charge_id)
        response = RestClient.get API.url("charge/#{charge_id}"), {
          'X-ApiKey' => Brickwall.configuration.brick_private_key
        }
        JSON.parse response
      end

      def self.refund(charge_id)
        response = RestClient.post API.url("charge/#{charge_id}/refund"), {}, {
          'X-ApiKey' => Brickwall.configuration.brick_private_key
        }
        JSON.parse response
      end

      def self.capture(charge_id)
        response = RestClient.post API.url("charge/#{charge_id}/capture"), {}, {
          'X-ApiKey' => Brickwall.configuration.brick_private_key
        }
        JSON.parse response
      end

      def self.void(charge_id)
        response = RestClient.post API.url("charge/#{charge_id}/void"), {}, {
          'X-ApiKey' => Brickwall.configuration.brick_private_key
        }
        JSON.parse response
      end
    end
  end
end
