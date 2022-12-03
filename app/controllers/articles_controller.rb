class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  # GET /players or /players.json
  def index
    if params[:query].present?
      @articles = Article.where("name like ?", "%#{params[:query]}%")

      if Search.exists?(name: params[:query])
        searched = Search.find_by(name: params[:query])
        sum = searched.search_count.to_i + 1
        searched.update(search_count: sum)
      else
        current_user.searches.create(name:params[:query])
      end

    else
      @articles = Article.all
    end
  end

  # GET /players/1 or /players/1.json
  def show
  end

  # GET /players/new
  def new
    @article = Article.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players or /players.json
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

  # PATCH/PUT /players/1 or /players/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1 or /players/1.json
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:name)
    end
end
