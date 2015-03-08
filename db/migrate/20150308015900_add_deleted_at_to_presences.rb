class AddDeletedAtToPresences < ActiveRecord::Migration
  def change
    add_column :presences, :deleted_at, :datetime
    add_index :presences, :deleted_at
  end
end
