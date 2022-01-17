module Admin
  class CountriesController < ApplicationController
    def index
      @pagy, @countries = pagy(Country.all)
    end
    def new
      @country = Country.new
    end
    def edit
      @country = Country.find(params[:id])
    end
    def create
      @country = Country.new(country_params)
      if @country.save
        redirect_to admin_countries_path, notice: I18n.t('admin.countries.notices.created')
      else
        render :new
      end
    end
    def update
      @country = Country.find(params[:id])
      if @country.update(country_params)
        redirect_to admin_countries_path, notice: I18n.t('admin.countries.notices.updated')
      else
        render :edit
      end
    end
    def destroy
      @country = Country.find(params[:id])
      if @country.destroy
        redirect_to admin_countries_path, notice: I18n.t('admin.countries.notices.deleted')
      else
        render :index
      end
    end

    def fetch_cities
      @cities = City.by_country(params[:country_id])
  
      render partial: 'cities', object: @cities, layout: false
    end

    private

    def country_params
      params
      .require(:country)
      .permit(:id, :name, :code, :active)
    end
  end
end