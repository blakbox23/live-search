class ArticlesController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:query].present? 
      @articles = Article.where("name like ?", "%#{params[:query]}%")

      if Search.exists?(name: params[:query])
        Search.add_count(params[:query])
        User.top_searched(current_user)

      else
        current_user.searches.create(name:params[:query])
        User.top_searched(current_user)
      end


    else
      @articles = Article.all
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:name, :body)
    end
end
