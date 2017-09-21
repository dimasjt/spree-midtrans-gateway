require "veritrans"

module Spree
  class Gateway::MidtransGateway < Gateway
    preference :client_key, :string
    preference :server_key, :string

    def provider_class
      ::Midtrans
    end

    def provider
      ::Midtrans.new(
        client_key: preferred_client_key,
        server_key: preferred_server_key,
        api_host: preferred_test_mode ? "https://api.sandbox.midtrans.com" : "https://api.midtrans.com"
      )
    end

    def method_type
      'midtrans'
    end

    def auto_capture?
      true
    end

    def supports?(source)
      true
    end

    def source_required?
      false
    end

    def charge(order)
      result = provider.charge(
        payment_type: "VTWEB",
        transaction_details: {
          order_id: order.number,
          gross_amount: order.total
        },
        # NOTE: items disabled because shipping and tax not provided by Midtrans
        # item_details: line_items(order),
        customer_details: customer(order)
      )

      order.payments.create!(
        amount: order.total,
        payment_method: self,
      )
      result
    end

    private

    def customer(order)
      billing = order.bill_address
      {
        first_name: billing.firstname,
        last_name: billing.lastname,
        email: order.email,
        phone: billing.phone,
        shipping_address: address(order.ship_address),
        billing_address: address(billing)
      }
    end

    def address(addrs)
      {
        first_name: addrs.try(:firstname),
        last_name: addrs.try(:lastname),
        phone: addrs.phone,
        address1: addrs.address1,
        city: addrs.city,
        postal_code: addrs.zipcode
      }
    end

    # def line_items(order)
    #   order.line_items.map do |li|
    #     {
    #       id: li.id,
    #       price: li.price,
    #       quantity: li.quantity,
    #       name: li.product.name
    #     }
    #   end
    # end
    #
  end
end
