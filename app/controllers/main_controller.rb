class MainController < ApplicationController
  before_action :fetch_booking, only: %i[current_step next_step]
  def index
    @vaccine_items = VaccineItem.active
  end

  def current_step
    @current_vaccine = VaccineItem.active.where("lower(name) = ?", vaccine_downcase).first

    return redirect_to root_url unless @current_vaccine

    case
    when @booking && @booking.vaccine.name != @current_vaccine.name
      web_step = Web::Step0Service.new(@current_vaccine)
      web_step.call(nil)
      
      @booking ||= web_step.booking
      set_browser_info
      @current_vaccine, @record = web_step.current_vaccine, web_step.record

      cookies.signed[:booking_uuid] = { value: @booking.guid, expires: 30.minutes.from_now }

      render :step0
    when @booking&.pending?
      web_step = Web::Step0Service.new(@current_vaccine)
      web_step.call(@booking)
      set_browser_info
      
      @current_vaccine, @record = web_step.current_vaccine, web_step.record
      
      render :step0
    when @booking.nil?
      web_step = Web::Step0Service.new(@current_vaccine)
      web_step.call(@booking)
      
      @booking ||= web_step.booking
      set_browser_info
      @current_vaccine, @record = web_step.current_vaccine, web_step.record

      cookies.signed[:booking_uuid] = { value: @booking.guid, expires: 30.minutes.from_now }

      render :step0
    when @booking.patient_upserted?
      render :step1
    when @booking.reserved?
      render :step2
    else
      cookies.delete(:booking_uuid)
      redirect_to root_url
    end
  end

  def next_step
  end

  def prev_step
  end

  def register
  end

  private

  def fetch_booking
    booking_uuid = cookies.signed[:booking_uuid]
    if booking_uuid.present?
      @booking = Booking.find_by(guid: booking_uuid)       
    end
  end

  def vaccine_downcase
    @vaccine_lower = params[:vaccine]&.downcase
  end

  def set_browser_info
    browser = Browser.new(request.env["HTTP_USER_AGENT"])
    @booking.ip_address = request.remote_ip
    @booking.browser_name = browser.name
    @booking.os_name = browser.platform.name
    @booking.save!
  end
end