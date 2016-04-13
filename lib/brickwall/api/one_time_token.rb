module Brickwall
  module API
    class OneTimeToken

      def self.create(card = {})
        response = RestClient.post API.url('token'), {
          public_key: Brickwall.configuration.brick_public_key,
          card: card
        }, {
          'X-ApiKey' => Brickwall.configuration.brick_private_key
        }
        JSON.parse response
      end
    end
  end
end
