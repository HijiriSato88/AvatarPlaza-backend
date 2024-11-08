class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :student_id, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.bigint :avatar_id, default: 1

      t.timestamps
    end
  end
end
