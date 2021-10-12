class AddIdUrlToIdentifications < ActiveRecord::Migration[5.1]
  def change
    add_column :identifications, :id_url, :string
  end
end
