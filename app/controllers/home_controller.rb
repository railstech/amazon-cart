class HomeController < ApplicationController
  def index
    @amazon_search = AmazonProductSearch.new
     @amazon_search.search(params)    
  end
  def search
    @amazon_search = AmazonProductSearch.new
     @amazon_search.search(params)
  end
end
