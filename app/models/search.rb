class Search < ApplicationRecord
  belongs_to :user

  def trending
    Searches.count(:all, :group => 'name', :order => 'count(*) DESC')
end
end
