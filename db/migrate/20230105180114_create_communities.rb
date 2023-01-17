class CreateCommunities < ActiveRecord::Migration[7.0]
  def change
    create_table :communities do |t|
      t.string :header
      t.integer :user_id
      t.string :username

      t.timestamps
    end
  end
end
