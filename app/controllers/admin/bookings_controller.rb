module Admin
  class BookingsController < ApplicationController
    
    def index
      @pagy, @bookings = pagy(Booking.with_patients)
    end
  end
end