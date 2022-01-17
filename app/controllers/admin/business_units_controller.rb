module Admin
  class BusinessUnitsController < ApplicationController
    before_action :set_default_countries, only: [:new, :create]
    def index
      @pagy, @business_units = pagy(BusinessUnit.all)
    end
    def new
      @business_unit = BusinessUnit.new
    end
    def edit
      @business_unit = BusinessUnit.find(params[:id])
      set_edit_countries
    end
    def create
      @business_unit = BusinessUnit.new(bu_params)
      if @business_unit.save
        redirect_to admin_business_units_path, notice: I18n.t('admin.business_units.notices.created')
      else
        @cities = City.by_country(@business_unit.country_id)
        @districts = District.by_city(@business_unit.city_id)
        render :new, status: 422
      end
    end
    def update
      @business_unit = BusinessUnit.find(params[:id])
      if @business_unit.update(bu_params)
        redirect_to admin_business_units_path, notice: I18n.t('admin.business_units.notices.updated')
      else
        @cities = City.by_country(@business_unit.country_id)
        @districts = District.by_city(@business_unit.city_id)
        @countries = Country.all
        render :edit, status: 422
      end
    end
    def destroy
      @business_unit = BusinessUnit.find(params[:id])
      if @business_unit.destroy
        redirect_to admin_business_units_path, notice: I18n.t('admin.business_units.notices.deleted')
      end
    end

    private

    def bu_params
      params
      .require(:business_unit)
      .permit(:id, :country_id, :city_id, :district_id, :name, :code, :active)
    end

    def set_default_countries
      @countries = Country.all
      @cities = []
      @districts = []
    end

    def set_edit_countries
      @countries = Country.all
      @cities = City.where(country_id: @business_unit.country_id)
      @districts = District.where(city_id: @business_unit.city_id)
    end
  end
end