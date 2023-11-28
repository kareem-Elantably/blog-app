class AddTagsToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :tags, :string
  end
end
