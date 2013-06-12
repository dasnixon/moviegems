class CreateMoviegems < ActiveRecord::Migration
  def change
    create_table :moviegems do |t|

      t.timestamps
    end
  end
end
