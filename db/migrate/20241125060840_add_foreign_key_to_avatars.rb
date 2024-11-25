class AddForeignKeyToAvatars < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :avatars, :users, column: :user_id, on_delete: :cascade
  end
end
