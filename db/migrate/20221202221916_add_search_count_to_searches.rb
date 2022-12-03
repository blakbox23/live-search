class AddSearchCountToSearches < ActiveRecord::Migration[7.0]
  def change
    add_column :searches, :search_count, :integer, :default => 1
  end
end
