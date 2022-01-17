module Admin
  class CitiesController < ApplicationController
    def index
      @pagy, @cities = pagy(City.all)
    end
    def new
      @city = City.new
    end
    def edit
      @city = City.find(params[:id])
    end
    def create
      @city = City.new(city_params)
      if @city.save
        redirect_to admin_cities_path, notice: I18n.t('admin.cities.notices.created')
      else
        render :new
      end
    end
    def update
      @city = City.find(params[:id])
      if @city.update(city_params)
        redirect_to admin_cities_path, notice: I18n.t('admin.cities.notices.updated')
      else
        render :edit
      end
    end
    def destroy
      @city = City.find(params[:id])
      if @city.destroy
        redirect_to admin_cities_path, notice: I18n.t('admin.cities.notices.deleted')
      else
        render :index
      end
    end
    def fetch_districts
      @districts = District.by_city(params[:city_id])
  
      render partial: 'districts', object: @districts, layout: false
    end

    private

    def city_params
      params
      .require(:city)
      .permit(:id, :country_id, :name, :code, :active)
    end
  end
end