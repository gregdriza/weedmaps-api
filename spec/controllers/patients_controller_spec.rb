require 'rails_helper'

RSpec.describe PatientsController, type: :controller do
  let!(:patient_1) { Patient.create(name: "Bloe Jogan", email: "Bloe@Jogan.biz", date_of_birth: Date.parse("1994-10-22")) }
  let!(:patient_2) { Patient.create(name: "Bomb Tegura", email: "Bomb@Tegura.biz", date_of_birth: Date.parse("1994-10-22")) }

  let!(:identification_1) { Identification.create(id_number: 123458574, 
                                                state_issuer: "NY", 
                                                expiration_date: Date.parse("2021-10-22"), 
                                                patient_id: patient_1.id, 
                                                id_url: "www.id-db.com/jogan") }
  let!(:identification_2) { Identification.create(id_number: 133557574, 
                                                  state_issuer: "NY", 
                                                  expiration_date: Date.parse("2021-10-22"), 
                                                  patient_id: patient_2.id, 
                                                  id_url: "www.id-db.com/Tegura") }

  before do
    Timecop.freeze(Time.local("2021-10-22"))
  end

  after do
    Timecop.return
  end

  fdescribe "GET index" do
    let(:expected_response) {
      [
        {
          "name"=>"Bloe Jogan",
          "date_of_birth"=>"1994-10-22",
          "email"=>"Bloe@Jogan.biz",
          "id"=>patient_1.id,
          "identifications"=>[{
            "expiration_date"=>"2021-10-22",
            "id"=>identification_1.id,
            "id_number"=>123458574,
            "is_expired"=>false,
            "id_url"=> "http://www.test.com/identifications/1/id_image/",
            "state_issuer"=>"NY"}]
        },
        {
          "name"=>"Bomb Tegura",
          "date_of_birth"=>"1994-10-22",
          "email"=>"Bomb@Tegura.biz",
          "id"=>patient_2.id,
          "identifications"=>[{
            "expiration_date"=>"2021-10-22",
            "id"=>identification_2.id,
            "id_number"=>133557574,
            "is_expired"=>false,
            "id_url"=> "http://www.test.com/identifications/2/id_image/",
            "state_issuer"=>"NY"}]
        }
      ]
    }

    before { get :index }
 
    it "returns all patients" do
      expect(JSON.parse(response.body)).to eq expected_response
    end
  end

  describe "GET show" do
    let(:expected_response) {
      {
        "name"=>"Bomb Tegura",
        "date_of_birth"=>"1994-10-22",
        "email"=>"Bomb@Tegura.biz",
        "id"=>patient_2.id,
        "identifications"=>[{
          "expiration_date"=>"2021-10-22",
          "id"=>identification_2.id,
          "id_number"=>133557574,
          "is_expired"=>false,
          "id_url"=> "http://www.test.com/identifications/2/id_image/",
          "state_issuer"=>"NY"}]
      }
    }

    before { get :show, params: { id: patient_2.id } }

    it "returns patient matching the provided id" do
      expect(JSON.parse(response.body)).to eq expected_response
    end
  end
  
  describe "POST new" do
    describe "when the patient has more than one identification" do
      let(:payload) {
        { 
          "patient": {
            "name"=>"Brick Spinkerton",
            "date_of_birth"=>"1994-10-22",
            "email"=>"Brick@Spinkerton.biz",
              "identifications"=>[{
                "expiration_date"=>"2021-10-22",
                "id_number"=>124557574,
                "state_issuer"=>"NY"
              },{
                "expiration_date"=>"2021-10-21",
                "id_number"=>124357644,
                "state_issuer"=>"NY"
              }
            ]
          }
        }
      }

      before { post :new, params: payload }

      it "creates the new patient and identifaction records" do
        new_patient = Patient.find_by(name: "Brick Spinkerton")
        expect(new_patient).not_to be nil 
      end
    end

    describe "when the patient has no identification" do
      let(:payload) {
        { 
          "patient": {
            "name"=>"Wonald Dump",
            "date_of_birth"=>"1994-10-22",
            "email"=>"Wonald@Dump.biz"
          }
        }
      }

      before { post :new, params: payload }

      it "creates the new patient and identifaction records" do
        new_patient = Patient.find_by(name: "Wonald Dump")
        expect(new_patient).not_to be nil 
      end
    end
  end

  describe "PATCH update" do
    let(:payload) {
      { 
        "patient": {
          "name"=>"Droe Gliden"
        }
      }
    }

    before { patch :update, params: { id: 1, **payload } }
  
    it 'updates the provided fields on the correct record' do
      updated_patient = Patient.find_by(name: "Droe Gliden")
      expect(updated_patient).not_to be nil
    end
  end

  describe "DELETE delete" do
    before { delete :delete, params: { id: 1 } }
    it "deletes the record matching the provided id" do
      deleted_patient = Patient.find_by(name: "Bloe Jogan")
      expect(deleted_patient).to be nil
    end
  end
end
