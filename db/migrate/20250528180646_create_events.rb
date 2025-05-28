class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.string :eventbrite_id
      t.string :name
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.string :url
      t.string :location

      t.timestamps
    end
  end
end
