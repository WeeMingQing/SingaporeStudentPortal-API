class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.text :content
      t.string :username
      t.integer :user_id
      t.integer :community_id
      t.string :community_header

      t.timestamps
    end
  end
end
