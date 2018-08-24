class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :status
      t.string :summary
      t.string :password

      t.timestamps
    end
  end
end
