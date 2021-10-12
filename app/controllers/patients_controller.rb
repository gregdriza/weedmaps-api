class PatientsController < ApplicationController
  skip_before_action :verify_authenticity_token
  ID_SERIALIZATION_ARGS = [ identification: { only: [:id_number, :state_issuer, :expiration_date]} ]

  def index
    @patients = Patient.all
    render json: @patients, include: [:identifications]
  end

  def new
    begin
      patient = params[:patient]
      if patient[:identifications]
        response = {
          patient: create_patient_with_identification(patient, patient[:identifications])
        } 

        render json: response.to_json
      else
        @patient = Patient.create(name: patient[:name], email: patient[:email], date_of_birth: patient[:date_of_birth])
        render json: @patient, include: [:identifications]
      end
    rescue => e
      render json: { error: e }, status: 422
    end
  end 

  def show
    @patient = Patient.find_by(id: params[:id])
    render json: @patient, include: [:identifications]
  end 

  def update
    begin
      update_parameters = params[:patient].as_json
      patient = Patient.find_by(id: params[:id])
      patient.update_attributes!(update_parameters)

      render json: patient, include: [:identifications]
    rescue => e
      render json: { error: e }, status: 422
    end
  end

  def delete
    begin
      @patient = Patient.where(id: params[:id]).first!.destroy!
      render json: @patient
    rescue => e
      puts e
      render json: { error: "Couldn't find patient" }
    end
  end

  private 
  
  def create_patient_with_identification(patient, ids)
    date_of_birth = Date.parse(patient[:date_of_birth])
    patient = Patient.create(name: patient[:name], 
                              email: patient[:email], 
                              date_of_birth: patient[:date_of_birth])

    ids.each do |identification| 
      expiration_date = Date.parse(identification[:expiration_date])
      Identification.create(state_issuer: identification[:state_issuer], 
                            id_number: identification[:id_number], 
                            expiration_date: expiration_date, 
                            patient_id: patient.id)
    end
    patient
  end
end
