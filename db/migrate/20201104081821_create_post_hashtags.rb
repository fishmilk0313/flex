class CreatePostHashtags < ActiveRecord::Migration[5.2]
  def change
    create_table :post_hashtags do |t|
      t.references :post_id, foreign_key: true
      t.references :hashtag_id, foreign_key: true
    end
  end
end
