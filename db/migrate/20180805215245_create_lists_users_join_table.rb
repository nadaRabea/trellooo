class CreateListsUsersJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :lists_users do |t|
      t.integer :user_id
      t.integer :list_id
    end
  end
end
