# brickwall

[![Code Climate](https://codeclimate.com/github/sujrd/brickwall/badges/gpa.svg)](https://codeclimate.com/github/sujrd/brickwall)
[![Gem Version](http://img.shields.io/gem/v/brickwall.svg)](https://rubygems.org/gems/brickwall)

Unofficial Paymentwall Brick API wrapper Ruby gem.

## Installation

    $ gem install brickwall

## Usage

Example barebones integration with Rails:

```ruby
# config/initializer/brickwall.rb
Brickwall.configure do |config|
  config.brick_public_key   = Rails.application.secrets.paymentwall_brick_public_key
  config.brick_private_key  = Rails.application.secrets.paymentwall_brick_private_key
  config.widget_project_key = Rails.application.secrets.paymentwall_widget_project_key
  config.widget_secret_key  = Rails.application.secrets.paymentwall_widget_secret_key
  config.application_domain = Rails.application.secrets.paymentwall_application_domain
end

# app/controllers/payments_controller.rb
class PaymentsController < ActionController::Base

  def create
    response_data = Brickwall::API::Charge.create({
      email: 'foo@example.com',
      amount: 3.50,
      currency: 'USD',
      token: params[:brick_token],
      fingerprint: params[:brick_fingerprint],
      description: 'Order #123',
    })
    if response_data['type'] == 'Error'
      render json: response_data, status: :unprocessable_entity
    else
      # Record result in DB
      render json: response_data, status: :created
    end
  end

end

# app/controllers/pingback_controller.rb
class PingbackController < ActionController::Base

  def index
    if Brickwall::Pingback.whitelisted_ip? request.remote_ip
      sig = Brickwall::Signature.calculate_v3 pingback_params
      if ActiveSupport::SecurityUtils.secure_compare sig, params[:sig]
        # Record result in DB
        render plain: 'OK'
      else
        raise ActionController::RoutingError, 'Not Found'
      end
    else
      raise ActionController::RoutingError, 'Not Found'
    end
  end

  private

  def pingback_params
    params.slice(:goodsid, :is_test, :ref, :sign_version, :slength,
                 :speriod, :type, :uid, :currency, :reason)
  end

end
```

## License

This gem is available under the MIT license. See the LICENSE file for more info.
