require 'simple_item'
require 'asin'
class AmazonProductSearch
  include AmazonProductApi
 
  
  GIFTOPEDIA_ITEMS={
    "AdventureSome"=> {
                    :keywords=>["adventure time", "travel", " adventure", " diaper caddy", "  swaddle", " travel bed. ", " travel kit", " travel size.", " adventurer", " lonely planet", " travel books", " travel guides", " ravel accessories", " travel games", " travel toys for toddlers", " travel watch", " gift baskets for women. gift baskets for men", " likes the mountains", " Xgames fan", " extreme sports", " bungee jumping", " extreme adventures", " scuba", " ", " skydive", " safari", " rock climb", " snowmobile", " adrenaline", " river rafting", " paraglide ", " hot air balloon", " handglide ", " survival activities", " splendunking", " bicycle tour", " dog sledding", " all terrain vehicle", " dog sledding", " base jumping"],
                  "nodes"=>(AMAZON_NODES.except_nodes([:All,:Automotive,:Blended, :DVD, :DigitalMusic,:GiftCards, :Industrial,:Kitchen,:Magazines,:SilverMerchants]))},

    "Chocoholic"=>{
            :keywords=>["Chocolate", "brown", "candles", "chocolate", "chocolate 2", "chocolate bar", "chocolate candy", "chocolate candy", "chocolate candy", "chocolate cookbook", "chocolate diamond", "chocolate diamonds. chocolat", "chocolate fountain", "chocolate games", "chocolate gifts", "chocolate handbags", "chocolate lotion", "chocolate molds", "chocolate skateboard clothing.", "chocolate skateboards", "chocolate soundtrack.", "chocolate touch", "dark chocolate", "fragrance", "gift baskets for men", "gift baskets for women.", "godiva", "lg chocolate.", "scents"],
           "nodes"=>AMAZON_NODES.except_nodes([:All,:Automotive,:Blended, :DVD, :DigitalMusic,:GiftCards, :Industrial,:Kitchen,:Magazines,:SilverMerchants])},


    "Do-It-Yourselfer"=>{
      :keywords=>["DIY", "do it yourself", "do it yourself home improvement", "do it yourself kits", "do it yourself magazine.", "handyman", "how-to & home improvements"],
      "nodes"=>(AMAZON_NODES.except_nodes    ([:All,:Automotive,:Blended, :DVD, :DigitalMusic,:GiftCards, :Industrial,:Kitchen,:Magazines,:SilverMerchants]))},


    "Flower Power"=> {
          :keywords=>["Flowers for delivery", "artificial flowers", "bulbs", "christmas flowers", "fake flowers", "flowers", "flowers delivery", "flowers delivery free shipping", "flowers with free delivery", "gift baskets for women", "lower arranging.", "plants", "seeds"],
     "nodes"=>(AMAZON_NODES.except_nodes([:All,:Automotive,:Blended, :DVD, :DigitalMusic,:GiftCards, :Industrial,:Kitchen,:Magazines,:SilverMerchants]))},

     "Gadgeteer"=>{
          :keywords=> ["Cook's Tool & Gadget Sets", "gadgets", "gadgets and gizmos", "gadgets electronic", "gadgets for geeks", "gadgets for men"],
            "nodes"=>(AMAZON_NODES.except_nodes([:All,:Automotive,:Blended, :DVD, :DigitalMusic,:GiftCards, :Industrial,:Kitchen,:Magazines,:SilverMerchants]))},

    "Foodie"=>{    
        :keywords=> ["baking", "beverages", "bon appetit", "breads", "candy", "cheese", "chocolate", "chowhound", "connoisseur", "cooking", "cooking", "epicurean", "epicurean", "food & wine", "food freak", "food lover", "food processor", "foodie games", "foodie gifts", "foodies", "gift baskets food", "gift baskets for women. epicure", "gourmand", "gourmet", "gourmet cookbook", "gourmet food", "gourmet gifts", "gourmet magazine.", "juicer", "prepared food", "sauces & dips", "sensual", "sensuous", "wine"] ,
       "nodes"=> [:Automative,:Appliances,:Books,:Magazines,:Baby,:GourmetFood,:Grocery,:HomeGarden,:Miscellaneous,:Photo]}
       }


  attr_accessor :keywords,:search_index,:response_group,:items,:review_items,:response,:department,:browse_node
  def initialize
    @client = ASIN::Client.instance
    @response_group = []
  end
  def search(params)
    build_search_params = {}
    @department = SEARCH_INDEX[params["search_index"].to_s] 
    #@keywords = params["keywords"].split(/,| /).join("+") rescue "All"
    @department =  SEARCH_INDEX["All"] if @department.nil?
    @search_index = @department[:SearchIndex].flatten.uniq.compact rescue :All
    @browse_node =  @department[:BrowseNode].flatten.uniq.compact rescue nil
    @keywords = params["keywords"]
    @response_group <<  :Large
    @response_group <<  :SearchBins
   @response_group <<  :BrowseNodes #unless @browse_node.nil? || @browse_node.empty?
    @response_group << params["response_group"] 
    @search_index = [:All] if @search_index.nil? || @search_index.empty? && @browse_node.empty?
    
    if @search_index == [:All]
      build_search_params={:SearchIndex => @search_index , :ResponseGroup  => @response_group.flatten.uniq.compact,:Keywords=>@keywords}
    elsif
      build_search_params =   {:SearchIndex => @search_index , :ResponseGroup  => @response_group.flatten.uniq.compact,:Keywords=>@keywords,:BrowseNode=>@browse_node}
    end
    @items,@response = @client.search(build_search_params)
     
   # fetch_review_items
  end
  def total_pages 
    @response['ItemSearchResponse']['Items']['TotalPages'] rescue 0
  end
  def total_results
    @response['ItemSearchResponse']['Items']['TotalResults'] rescue 0
  end

  def narrow_by_subject
    @response["ItemSearchResponse"]["Items"]["SearchBinSets"]["SearchBinSet"][0]["Bin"] rescue []
  end
  def narrow_by_brand_name
    @response["ItemSearchResponse"]["Items"]["SearchBinSets"]["SearchBinSet"][1]["Bin"] rescue []
  end
  def narrow_by_price_range
    @response["ItemSearchResponse"]["Items"]["SearchBinSets"]["SearchBinSet"][2]["Bin"] rescue []
  end
  def narrow_by_special_size
    @response["ItemSearchResponse"]["Items"]["SearchBinSets"]["SearchBinSet"][3]["Bin"] rescue []
  end
end
