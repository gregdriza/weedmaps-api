class CreateIdentifcations < ActiveRecord::Migration[5.1]
  def change
    create_table :identifications do |t|
      t.integer :id_number
      t.string :state_issuer
      t.date :expiration_date
      t.references :patient, foreign_key: true
    end
  end
end
