
class Patient < ApplicationRecord
  has_many :identifications, :dependent => :destroy
end
