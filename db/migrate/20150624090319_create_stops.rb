class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      t.string :title
      t.string :tag
      t.string :code
      t.float :latitude
      t.float :longitude
      t.integer :route_id, index: true

      t.timestamps null: false
    end
    add_index :stops, [:tag, :route_id], unique: true
  end
end
