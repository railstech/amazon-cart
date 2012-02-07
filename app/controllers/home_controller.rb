class HomeController < ApplicationController
  def index
    @items=[]
    @amazon_search = AmazonProductSearch.new
     @amazon_search.search(params)
  end
end
