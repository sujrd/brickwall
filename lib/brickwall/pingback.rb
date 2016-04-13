module Brickwall
  module Pingback
    IP_WHITELIST = %w(
      174.36.92.186
      174.36.92.187
      174.36.92.192
      174.36.96.66
      174.37.14.28
    )

    def self.whitelisted_ip?(ip_address)
      if ip_address.start_with? '174.3'
        IP_WHITELIST.any? { |address| ip_address == address }
      else
        false
      end
    end
  end
end
