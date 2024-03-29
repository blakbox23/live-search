class Search < ApplicationRecord
  belongs_to :user

  def self.current_user_trending(user)
    user.searches.where("search_count > 0").order('search_count DESC').limit(3)
  end

  def self.add_count(phrase)
    searched = Search.find_by(name: phrase)
    sum = searched.search_count.to_i + 1
    searched.update(search_count: sum) 
  end

  
end
