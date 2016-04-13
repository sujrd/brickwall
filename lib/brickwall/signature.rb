module Brickwall
  module Signature
   class << self
     def calculate_v2(params = {})
       data = string_params(sorted_params!(params.to_a)) + Brickwall.configuration.widget_secret_key
       Digest.hexencode OpenSSL::Digest::MD5.digest data
     end

     def calculate_v3(params = {})
       data = string_params(sorted_params!(params.to_a)) + Brickwall.configuration.widget_secret_key
       Digest.hexencode OpenSSL::Digest::SHA256.digest data
     end

     private

     def sorted_params!(arr_params)
       arr_params.sort! { |(k1,_), (k2,_)| k1 <=> k2 }
     end

     def string_params(arr_params)
       str = StringIO.new
       arr_params.each do |(k, v)|
         str << k.to_s
         str << '='
         str << v.to_s
       end
       str.string
     end
   end
  end
end
