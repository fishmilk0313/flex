class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
    	t.integer :user_id, foreign_key: true
    	t.integer :hashtag_id ,foreign_key: true
    	t.text :text, null: false
    	t.string :image_id


      t.timestamps
    end
  end
end
