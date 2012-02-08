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


  attr_accessor :keywords,:search_index,:response_group,:items,:review_items,:response,:department
  attr_accessor :department_key,:browse_node,:brand,:maximum_price,:minimum_price,:condition
  def initialize
    @client = ASIN::Client.instance
    @response_group = []
    @browse_node = []
    @brand = []
  end
  def search(params)
    search_params = {}
    @department_key = params["department"].to_s
    @department = SEARCH_INDEX[params["department"].to_s] 
    #@keywords = params["keywords"].split(/,| /).join("+") rescue "All"
    search_index = params["SearchIndex"].to_sym if params["SearchIndex"] && @department.nil? 
    @department =  SEARCH_INDEX["All"] if @department.nil?
    
    @search_index = search_index || @department[:SearchIndex].flatten.uniq.compact rescue :All
    @browse_node  << params["BrowseNode"] if params["BrowseNode"]
    @browse_node  <<  @department[:BrowseNode].flatten.uniq.compact rescue nil
    @brand << params["Brand"] unless params["Brand"].nil? || params["Brand"].empty?
    @maximum_price = params["MaximumPrice"] unless params["MaximumPrice"].nil? || params["MaximumPrice"].empty?
    @minimum_price = params["MinimumPrice"] unless params["MinimumPrice"].nil? || params["MinimumPrice"].empty?
    @keywords = params["keywords"]
    @response_group <<  :Large
    @response_group <<  :SearchBins
    @response_group <<  :BrowseNodes #unless @browse_node.nil? || @browse_node.empty?
    @response_group << params["response_group"] 
    @search_index = [:All] if @search_index.nil? || @search_index.empty? && @browse_node.empty?
    @browse_node= @browse_node.join(",") rescue nil
    
    if @search_index == [:All]
     @keywords = "a" if @keywords.nil? || @keywords.blank?
      search_params={:SearchIndex => @search_index , :ResponseGroup  => @response_group.flatten.uniq.compact,:Keywords=>@keywords}
    else
      if @keywords.nil? || @keywords.blank?
          @keywords =[@search_index].join(",") 
       end   
     search_params =   
     {:SearchIndex => @search_index , :ResponseGroup  => @response_group.flatten.uniq.compact,
          :Keywords=>@keywords,:BrowseNode=>@browse_node,:Brand=>@brand,:MinimumPrice=>@minimum_price,:MaximumPrice=>@maximum_price}
    end
   
    @items,@response = @client.search(search_params)
     
   # fetch_review_items
  end
  
  def total_pages 
    @response['ItemSearchResponse']['Items']['TotalPages'] rescue 0
  end
  def total_results
    @response['ItemSearchResponse']['Items']['TotalResults'] rescue 0
  end

  def build_search_params
    search_params = ""
     if @search_index.is_a?(Array)
        search_index = @search_index.join(",")
     elsif @search_index.is_a?(Symbol)
      search_index = @search_index.to_s
     else
      search_index = @search_index.to_s
     end   
    search_params << "keywords=#{@keywords}&SearchIndex=#{search_index}"
  end 




# NARROWED BY 
#TODO MAKE MODULE AND INCLUDE IT
  def narrow_by
    search_index = @search_index.is_a?(Array) ? @search_index[0] : @search_index
    narrow_by_value = SEARCH_INDEX.values.select {|s|s[:SearchIndex] == [search_index.to_sym]}
    
    unless narrow_by_value.nil? || narrow_by_value.empty?
      narrow_by_value[0][:NarrowBy] 
    else
      []
    end
  end
  def narrow_by_subject
     begin
      if @response["ItemSearchResponse"]["Items"]["SearchBinSets"]["SearchBinSet"][0]["Bin"] 
        [@response["ItemSearchResponse"]["Items"]["SearchBinSets"]["SearchBinSet"][0]["Bin"]].flatten 
      else
        []
      end  
     rescue 
        []
     end
  end

  def narrow_by_brand_name
    begin
     if @response["ItemSearchResponse"]["Items"]["SearchBinSets"]["SearchBinSet"][1]["Bin"]
      [@response["ItemSearchResponse"]["Items"]["SearchBinSets"]["SearchBinSet"][1]["Bin"]].flatten
      else
        []
      end
     rescue 
      []
     end 
  end

  def narrow_by_price_range
    begin
     if @response["ItemSearchResponse"]["Items"]["SearchBinSets"]["SearchBinSet"][2]["Bin"]
      [@response["ItemSearchResponse"]["Items"]["SearchBinSets"]["SearchBinSet"][2]["Bin"]].flatten
     else
      []
     end 
    rescue
       []
     end 
    
  end

  def narrow_by_special_size
    @response["ItemSearchResponse"]["Items"]["SearchBinSets"]["SearchBinSet"][3]["Bin"] rescue []
  end

  def bin_name(bin)
    bin["BinName"]
  end
  def bin_item_count(bin)
    bin["BinItemCount"]
  end
  
  def browse_node_from_bin(bin)
     bin["BinParameter"]["Value"] if bin["BinParameter"] &&  bin["BinParameter"]["Name"]=="BrowseNode" rescue ''
  end
  def brand_name_from_bin(bin)
     bin["BinParameter"]["Value"] if bin["BinParameter"] &&  bin["BinParameter"]["Name"]=="Brand" rescue nil
  end
 
  def min_price_from_bin(bin)
    price_range_from_bin(bin)[0].to_s
  end

  def max_price_from_bin(bin)
    price_range_from_bin(bin)[1].to_s
  end

  
  def price_range_from_bin(bin)
    minimum,maximum = 0,100000000
    if bin["BinParameter"]
      if  bin["BinParameter"].is_a?(Array )
        minimum = bin["BinParameter"][0]["Name"]== "MinimumPrice" ? bin["BinParameter"][0]["Value"] : bin["BinParameter"][1]["Value"] rescue 0
        maximum = bin["BinParameter"][1]["Name"]== "MaximumPrice" ? bin["BinParameter"][1]["Value"] : bin["BinParameter"][0]["Value"] rescue 0
      else
        if bin["BinParameter"]["Name"]=="MinimumPrice"
          minimum = bin["BinParameter"]["Value"]   
        elsif bin["BinParameter"]["Name"]=="MaximumPrice"
           maximum = bin["BinParameter"]["Value"]   
        end  
      end  
    end  
    [minimum,maximum]
  end
  
  def percentage_off_from_bin(bin)
    bin["BinParameter"]["Value"] if bin["BinParameter"] &&  bin["BinParameter"]["Name"]=="MinPercentageOf"
  end
end
