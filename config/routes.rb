Spree::Core::Engine.add_routes do
  get "/payment/midtrans/success", to: "midtrans#success", as: :midtrans_success
  post "/payment/midtrans/notifications", to: "midtrans#notifications", as: :midtrans_notifications
  post "/payment/midtrans/charge", to: "midtrans#charge", as: :midtrans_charge
end
