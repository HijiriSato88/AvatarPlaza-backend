class CreateAvatars < ActiveRecord::Migration[7.1]
  def change
    create_table :avatars, id:false do |t|
      t.string :avatar_id, primary_key: true
      t.integer :body, default: 0
      t.integer :accessory, default: 0
      t.boolean :logged_in, default: false
      t.timestamps

    end
    add_foreign_key :users, :avatars, column: :avatar_id, primary_key: :avatar_id
  end
end
