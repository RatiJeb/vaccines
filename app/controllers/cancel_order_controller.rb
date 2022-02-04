class CancelOrderController < ApplicationController

  def index
  end

  def order_found
    @current_order = Order.find_by(order_code: params[:code])

    order_mobile_phone = @current_order&.patient&.mobile_phone
    current_mobile_phone = params[:mobile_phone]

    return render partial: 'order_info', object: @current_order if order_mobile_phone == current_mobile_phone
    render partial: 'errors'

  end

  def send_verification
    fetch_current_order
    sms = Web::GenerateVerificationSmsService.new(@current_order, @booking_id).call
    SendVerifySmsWorker.perform_async(sms.id)
  end

  def verify_code
    fetch_current_order
    current_sms = VerifySmsMessage.where(booking_id: @booking_id).last
    if current_sms.code == params[:code_input]
      redirect_to root_path, notice: I18n.t('web.cancel_reservation.order.notice') if @current_order.update(finished: false)
    else
      render partial: 'errors'
    end
  end

  private

  def fetch_current_order
    @current_order = Order.find(params[:current_order_id])
    @booking_id = Booking.find_by(order: @current_order).id
  end
end