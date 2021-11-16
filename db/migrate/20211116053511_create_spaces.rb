class CreateSpaces < ActiveRecord::Migration[5.2]
  def change
    create_table :spaces do |t|
    t.string :name
    t.string :introduction
    
    t.datetime :remember_created_at
    t.datetime :remember_updated_at
    
    t.timestamps
    end
  end
end
