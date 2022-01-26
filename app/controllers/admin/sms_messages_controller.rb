module Admin
  class SmsMessagesController < ApplicationController
    def index
      @pagy, @sms = pagy(OrderSmsMessage.all)
    end
  end
end