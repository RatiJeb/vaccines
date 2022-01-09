module Admin
  class MainController < ApplicationController
    def index
      @bookings = Booking.count
      @users = User.count
      @vaccine_items = VaccineItem.count
    end
  end
end