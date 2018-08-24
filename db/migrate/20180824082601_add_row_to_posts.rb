class AddRowToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :row, :integer
    add_column :posts, :column, :string
  end
end
