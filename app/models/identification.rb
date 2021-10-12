
class Identification < ApplicationRecord
  VALID_STATES = ['AK', 'AL' 'AR', 'AZ','CA','CO','CT','DE' 'FL', 'GA','GA','HI','IA','ID','IL',
                  'IN','KS','KY','LA','MA','MD','ME','MI','MN','MO','MS','MT','NC','ND','NE','NH',
                  'NJ','NM','NV','NY','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VA','VT',
                  'WA','WI','WV','WY'].freeze

  belongs_to :patient, optional: true

  validates :id_number, format: { with: /\A\d{9}\z/ }, allow_blank: false, uniqueness: true
  validates :state_issuer, presence: true, :inclusion=> { :in => VALID_STATES }
end
