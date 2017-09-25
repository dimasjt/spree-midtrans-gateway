module Spree
  class MidtransController < StoreController
    skip_before_action :verify_authenticity_token, only: :notifications

    # this action redirected from /checkout/payment
    # will redirect to midtrans page
    def charge
      order = current_order || raise(ActiveRecord::RecordNotFound)
      payment_method = Spree::PaymentMethod.where(type: "Spree::Gateway::MidtransGateway").find(params[:payment_method_id])
      charge = payment_method.charge(order)

      order.next

      if charge.success? && order.complete?
        redirect_to charge.redirect_url
      else
        flash[:error] = charge.data[:message]
        redirect_to checkout_state_path(:payment)
      end
    end

    # action to process after success in midtrans page
    # have params :order_id as Spree::Order#number
    def success
      order = Spree::Order.find_by!(number: params[:order_id])

      redirect_to order_path(order)
    end

    # this action will run when Midtrans send notification by webhook
    # https://dashboard.sandbox.midtrans.com/settings/vtweb_configuration
    def notifications
      order = Spree::Order.find_by_number(params[:order_id])

      order.payment_state =
        case params[:transaction_status]
        when "expired", "cancel"
          "failed"
        when "pending"
          "pending"
        when "capture"
          "processing"
        when "settlement"
          "completed"
        end

      order.save
      head 200
    end
  end
end
