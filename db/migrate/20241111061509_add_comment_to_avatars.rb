class AddCommentToAvatars < ActiveRecord::Migration[7.1]
  def change
    add_column :avatars, :comment, :string, default: ""
  end
end