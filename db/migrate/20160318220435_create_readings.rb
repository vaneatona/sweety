class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.belongs_to :user, index: true
      t.string :title
      t.integer :blood_sugar
      t.timestamps null: false
    end
  end
end