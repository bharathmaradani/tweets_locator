class TweetsController < ApplicationController
  
  def index
    @tweets = Tweet.limit(100)
  end

  def search
    location = [params[:longitude].to_f, params[:latitude].to_f]
    @tweets = Tweet.geo_near(location).max_distance(params[:radius].to_f)
    if params[:longitude].blank? || params[:latitude].blank? || params[:radius] || @tweets.empty?
      flash[:notice] = "No Data Found.. Showing first 100 records"
      index
    end
    render 'index'
  end

  def show
    @tweet = Tweet.find(params[:id])
  end
end
