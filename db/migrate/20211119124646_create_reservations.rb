class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
    t.integer :user_id
    t.integer :space_id
    t.datetime :start_date
    t.datetime :start_time
    t.datetime :end_date
    t.datetime :end_time
      t.timestamps
    end
  end
end
