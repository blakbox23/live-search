class AddTrendingToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :trending, :string
  end
end
