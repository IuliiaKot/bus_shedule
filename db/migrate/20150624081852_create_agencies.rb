class CreateAgencies < ActiveRecord::Migration
  def change
    create_table :agencies do |t|
      t.string :title
      t.string :tag

      t.timestamps null: false
    end
  end
end
