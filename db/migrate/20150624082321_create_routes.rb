class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :title
      t.string :tag
      t.integer :agency_id, index: true

      t.timestamps null: false
    end

    add_index :routes, [:tag, :agency_id], unique: true
  end
end
