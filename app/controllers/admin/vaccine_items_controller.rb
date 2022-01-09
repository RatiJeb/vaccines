module Admin
  class VaccineItemsController < ApplicationController
    before_action :init_service

    def index
      @pagy, @vaccine_items = pagy(@vaccine_item_service.list)
    end

    def new
      result = @vaccine_item_service.new

      @vaccine_item = result.vaccine_item
    end

    def edit
      result = @vaccine_item_service.edit(params[:id])

      @vaccine_item = result.vaccine_item
    end

    def create
      result = @vaccine_item_service.create(create_vaccine_item_params)

      @vaccine_item = result.vaccine_item

      if result.success?
        redirect_to admin_vaccine_items_path, notice: I18n.t('admin.vaccine_items.notices.created')
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      result = @vaccine_item_service.update(params[:id], update_vaccine_item_params)

      @vaccine_item = result.vaccine_item

      if result.success?
        redirect_to admin_vaccine_items_path, notice: I18n.t('admin.vaccine_items.notices.updated')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      result = @vaccine_item_service.delete(params[:id])

      if result.success?
        redirect_to admin_vaccine_items_path, notice: I18n.t('admin.vaccine_items.notices.deleted')
      end
    end

    private

    def init_service
      @vaccine_item_service = VaccineItems::VaccineItemService.new
    end

    def create_vaccine_item_params
      params.require(:vaccine_item).permit(:name, :description, :active)
    end

    def update_vaccine_item_params
      params.require(:vaccine_item).permit(:id, :name, :description, :active)
    end
  end
end