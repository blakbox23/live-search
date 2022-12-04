class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_many :searches

    def self.top_searched(user)
      count = user.searches.maximum(:search_count)
      most_searched = user.searches.find_by(search_count: count)
      if most_searched
      user.update(trending: most_searched.name)
      end
    end 
end
