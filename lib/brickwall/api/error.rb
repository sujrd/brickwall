module Brickwall
  module API
    class Error < Struct.new(:type, :error, :code)

      # From https://www.paymentwall.com/en/documentation/Brick/2968#list-of-error-codes
      def user_error?
        case code
        when 3003..3112 then true
        when 3200 then true
        when 5000 then true
        else false
        end
      end

    end
  end
end
