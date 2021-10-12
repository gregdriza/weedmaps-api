class PatientSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :date_of_birth
  has_many :identifications
end
