module Admin
  class DistrictsController < ApplicationController
    def index
      @pagy, @districts = pagy(District.all)
    end
    def new
      @district = District.new
    end
    def edit
      @district = District.find(params[:id])
    end
    def create
      @district = District.new(district_params)
      if @district.save
        redirect_to admin_districts_path, notice: I18n.t('admin.districts.notices.created')
      else
        render :new
      end
    end
    def update
      @district = District.find(params[:id])
      if @district.update(district_params)
        redirect_to admin_districts_path, notice: I18n.t('admin.districts.notices.updated')
      else
        render :edit
      end
    end
    def destroy
      @district = District.find(params[:id])
      if @district.destroy
        redirect_to admin_districts_path, notice: I18n.t('admin.districts.notices.deleted')
      else
        render :index
      end
    end

    private

    def district_params
      params
      .require(:district)
      .permit(:id, :city_id, :name, :code, :active)
    end
  end
end