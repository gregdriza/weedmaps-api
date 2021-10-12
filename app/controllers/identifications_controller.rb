require 'securerandom'

class IdentificationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index
    @identifications = Identification.all
    render json: @identifications, include: []
  end

  ##

  def upload
    begin
      identification = Identification.find_by(id: params[:id])
      extension = params[:file].original_filename.split('.')
      new_image = "identification-#{SecureRandom.uuid}.#{extension[1]}"
    
      File.open("images/#{new_image}",'wb') do |f|
        f.write params[:file].read
      end
      
      identification.update(id_url: "images/#{new_image}")
    
      render json: identification
    rescue => e
      render json: e, status: 409
    end
  end

  def get_id_image
    begin
      identification = Identification.find_by(id: params[:id])
      file = File.open("#{identification.id_url}", 'r')
      send_file(file, :disposition => 'inline', :type => 'image/jpeg', :status => 200)
    rescue => e
      render json: { error: e }
    end
  end

  def new
    begin
      expiration_date = Date.parse(params[:expiration_date])
      @identification = Identification.create!(state_issuer: params[:state_issuer], id_number: params[:id_number], expiration_date: expiration_date)
      render json: @identification, include: []
    rescue => e
      render json: { error: e }, status: 422
    end
  end 

  def show
    @identification = Identification.find_by(id: params[:id])
    render json: @identification,  include: []
  end 

  def update
    begin
      update_parameters = params['identification'].as_json

      @identification = Identification.find_by(id: params[:id])
      @identification.update_attributes!(update_parameters)
      render json: @identification,  include: []
    rescue => e
      render json: { error: e }
    end
  end

  def delete
    begin
      identification = Identification.where(id: params[:id]).first!.destroy!
      render json: { deleted_id: identification }
    rescue => e
      render json: { error: "Couldn't find ID" }
    end
  end
end