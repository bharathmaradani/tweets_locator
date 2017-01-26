class TweetsController < ApplicationController
  
  def index
    @tweets = Tweet.all
  end

  def search
    
  end

  def show
    @tweet = Tweet.find(params[:id])
  end
end
