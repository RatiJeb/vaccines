module Admin
  class PatientsController < ApplicationController
    attr_reader :patient

    def index
      @pagy, @patients = pagy(Patient.all)
    end

    def edit
      @patient = Patient.find(params[:id])
    end
    
    def update
      @patient = Patient.find(params[:id])
      if @patient.update!(patient_params)
        redirect_to admin_patients_path, notice: I18n.t('admin.patients.notices.updated')
      else
        render :edit
      end
    end

    private

    def patient_params
      params.require(:patient).permit(:mobile_phone)
    end
  end
end