require 'rails_helper'

RSpec.describe IdentificationsController, type: :controller do
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
    Timecop.freeze(Time.local('2021-10-22'))
  end

  after do
    Timecop.return
  end

  describe "GET index" do
    let(:expected_response) {
      [
        {
          "expiration_date"=>"2021-10-22",
          "id"=>identification_1.id,
          "id_number"=>123458574,
          "is_expired"=>false,
          "state_issuer"=>"NY",
          "id_url"=> 'http://www.test.com/identifications/1/id_image/'
        },
        {
          "expiration_date"=>"2021-10-22",
          "id"=>identification_2.id,
          "id_number"=>133557574,
          "is_expired"=>false,
          "state_issuer"=>"NY",
          "id_url"=>"http://www.test.com/identifications/2/id_image/"
        }
      ]
    }

    before { get :index }
 
    it "returns all identifications" do
      expect(JSON.parse(response.body)).to eq expected_response
    end
  end

  describe "GET show" do
    let(:expected_response) {
      {
        "expiration_date"=>"2021-10-22",
        "id"=>identification_2.id,
        "id_number"=>133557574,
        "is_expired"=>false,
        "state_issuer"=>"NY",
        "id_url"=>"http://www.test.com/identifications/2/id_image/"
      }
    }

    before { get :show, params: { id: identification_2.id } }

    it "returns patient matching the provided id" do
      expect(JSON.parse(response.body)).to eq expected_response
    end
  end
  
  describe "POST new" do
    describe "when the patient has more than one identification" do
      let(:payload) {
        { 
          "expiration_date"=>"2021-10-22",
          "id_number"=>124557574,
          "state_issuer"=>"NY"
        }
      }

      before { post :new, params: payload }

      it "creates the new patient and identifaction records" do
        new_identification = Identification.find_by(id_number: 124557574)
        expect(new_identification).not_to be nil 
      end
    end
  end

  describe "PATCH update" do
    let(:payload) {
      {
        "identification": {
          "id_number"=>987654321
        }
      }
    }

    before { patch :update, params: { id: 1, **payload } }

    it "updates the provided fields on the correct record" do
      updated_identification = Identification.find_by(id_number: 987654321)
      expect(updated_identification).not_to be nil
    end
  end

  describe "DELETE delete" do
    before { delete :delete, params: { id: 1 } }

    it "updates the provided fields on the correct record" do
      deleted_identification = Identification.find_by(id_number: 987654321)
      expect(deleted_identification).to be nil
    end
  end

  describe "POST upload" do
    describe "when a file is posted to upload" do
      before do
        @file = fixture_file_upload("image2.gif", "image/gif")
        allow(SecureRandom).to receive(:uuid).and_return("random-uuid")
        post :upload, params: payload
      end

      let(:payload) {
        { 
          file: @file,
          id: identification_1.id
        }
      }

      it "updates the identification record with the url where it can be viewed" do
        new_identification = Identification.find_by(id: identification_1.id)
        expect(new_identification.id_url).to eq "images/identification-random-uuid.gif"
      end

      it "returns the url" do
        expect(JSON.parse(response.body)).to eq({
          "expiration_date" => "2021-10-22",
          "id" => 1,
          "id_number" => 123458574,
          "id_url" => "http://www.test.com/identifications/1/id_image/",
          "is_expired" => false,
          "patient" => {"date_of_birth"=>"1994-10-22", "email"=>"Bloe@Jogan.biz", "id"=>1, "name"=>"Bloe Jogan"},
          "state_issuer" => "NY"
        })
      end
    end
  end
end
