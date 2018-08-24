class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :status
      t.string :summary
      t.string :password
      t.integer :likes, default: 0
      t.integer :views, default: 0

      t.timestamps
    end
  end
end
