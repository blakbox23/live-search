class SearchesController < ApplicationController
    def index
        @searches = Search.where("search_count > 0").order('search_count DESC')
    end  
    def new
        @search = Search.new
    end  
    def create

        if params[:query].present?
            @search = Search.new(params[:query])
        end
        
      
        if @search.save
          redirect_to articles_path
        else
          flash[:error] = @search.errors.full_messages
          redirect_to articles_path
        end  
    end  
    
    def show
        redirect_to @search.sanitize
      end
end
