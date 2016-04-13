module Brickwall
  module API
    def self.url(fragment)
      "https://api.paymentwall.com/api/brick/#{fragment}"
    end
  end
end

require 'brickwall/api/error'
require 'brickwall/api/charge'
require 'brickwall/api/one_time_token'
require 'brickwall/api/subscription'
