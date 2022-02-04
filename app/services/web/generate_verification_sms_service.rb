module Web
  class GenerateVerificationSmsService
    attr_reader :booking

    def initialize(current_order, booking_id)
      @current_order = current_order
      @booking_id = booking_id
    end

    def call
      code = 6.times.map{rand(10)}.join
      VerifySmsMessage.create!(booking_id: @booking_id, code: code, approved_at: DateTime.now )
    end
  end
end