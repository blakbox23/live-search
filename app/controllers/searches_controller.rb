class SearchesController < ApplicationController
  before_action :authenticate_user!
    def index
        @searches = Search.current_user_trending(current_user).limit(3)
        @users = User.all
    end  
end
