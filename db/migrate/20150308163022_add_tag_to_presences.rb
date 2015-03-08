class AddTagToPresences < ActiveRecord::Migration
  def change
    add_reference :presences, :tag, index: true
    add_foreign_key :presences, :tags
  end
end
