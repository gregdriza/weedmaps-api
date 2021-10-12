class IdentificationSerializer < ActiveModel::Serializer
  attributes :id, :state_issuer, :expiration_date, :id_number, :id_url, :is_expired
  belongs_to :patient


  def id_url
    "http://#{ENV['url']}/identifications/#{object.id}/id_image/"
  end

  def is_expired
    Date.today >= object.expiration_date
  end
end
