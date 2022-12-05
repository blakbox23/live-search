 RSpec.describe 'Article', type: :model do
    it "is not valid without a name" do
      article = Article.new(name: nil)
      expect(article).to_not be_valid
    end
    it "is not valid without a body" do
      article = Article.new(body: nil)
      expect(article).to_not be_valid
    end
  end