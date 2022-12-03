class RenamePlayersToArticles < ActiveRecord::Migration[7.0]
  def self.up
    rename_table :players, :articles
  end

  def self.down
    rename_table :articles, :players
  end
end
