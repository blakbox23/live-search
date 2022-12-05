class SearchesController < ApplicationController
  before_action :authenticate_user!
    def index
        @searches = Search.current_user_trending(current_user)
        @users = User.all
    end  
end
