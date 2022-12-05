require 'rails_helper'

RSpec.describe 'Search', type: :model do
  it 'should belong to a user' do
    a = Search.reflect_on_association(:user)
    expect(a.macro).to eq(:belongs_to)
  end
  
  it "Should only have distinct search phrases" do
    search1 = Search.new(name: 'Rails article')
    search2 = Search.new(name: 'Rails article')
    expect(search2).to_not be_valid
  end

  it "User trending should have highest search-count" do
    user = User.create( 
    email: 'test@example.com', 
    password: 'password123',
    password_confirmation: 'password123'
    )
    user.searches.create(name: 'phrase')
    highest_searchcount = user.searches.where("search_count > 0").order('search_count DESC').first.name
    User.top_searched(user)
    user_trending = user.trending
    
    expect(highest_searchcount).to be == user_trending
 end
end