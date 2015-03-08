class CreatePresences < ActiveRecord::Migration
  def change
    create_table :presences do |t|
      t.references :user, index: true
      t.references :room, index: true

      t.timestamps null: false
    end
    add_foreign_key :presences, :users
    add_foreign_key :presences, :rooms
  end
end
