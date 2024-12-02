class UpdateAvatarsColumns < ActiveRecord::Migration[7.1]
  def change
    rename_column :avatars, :body, :accessory_body
    rename_column :avatars, :accessory, :accessory_head
    add_column :avatars, :accessory_leg, :integer, default: 0
  end
end
