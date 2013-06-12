class CreateMoviegems < ActiveRecord::Migration
  def change
    create_table :moviegems do |t|
      t.string :link
      t.string :name
      t.references :user
      t.timestamps
    end
  end
end
