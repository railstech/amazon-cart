require 'simple_item'
module AmazonProductApi

  AMAZON_NODES = [:All, :Apparel, :Appliances, :ArtsAndCrafts, :Automotive, :Baby, :Beauty, :Blended, :Books, 
 :DVD, :DigitalMusic, :Electronics, :GiftCards, :GourmetFood, :Grocery, :HealthPersonalCare, :HomeGarden,
 :Industrial, :Jewelry, :KindleStore, :MP3Downloads, :Magazines, :Miscellaneous, :MobileApps, :Music,
 :MusicalInstruments, :OfficeProducts, :OutdoorLiving, :PCHardware, :PetSupplies, :Photo, :Shoes, 
 :SilverMerchants, :Software, :SportingGoods, :Tools, :Toys, :VHS, :Video, :VideoGames, :Watches, 
 :WirelessAccessories, :Wirelses] 

  SEARCH_INDEX = {
    "All"=>{:SearchIndex=>[:All],:BrowseNode=>[nil]},
    "Apparel & Accessories"=>{:SearchIndex=>[:Apparel],:BrowseNode=>[1036592]},
    "Appliances"=>{:SearchIndex=>[:Appliances],:BrowseNode=>[nil]},
    "Arts and Crafts"=>{:SearchIndex=>[:ArtsAndCrafts],:BrowseNode=>[2617941011]},
    "Automotive"=>{:SearchIndex=>[:Automotive],:BrowseNode=>[15684181]},
    "Baby"=>{:SearchIndex=>[:Baby],:BrowseNode=>[165796011]},
    "Beauty"=>{:SearchIndex=>[:Beauty],:BrowseNode=>[3760911]},
  #  "Blended"=>:Blended,
    "Books"=>{:SearchIndex=>[:Books],:BrowseNode=>[283155]},
    "DVD"=>{:SearchIndex=>[:DVD],:BrowseNode=>[nil]} ,
    "Digital Music"=>{:SearchIndex=>[:DigitalMusic],:BrowseNode=>[nil]},
    "Electronics & Computers & Accessories"=>{:SearchIndex=>[:Electronics],:BrowseNode=>[172282]},      
    "Foreign Books"=>{:SearchIndex=>[:Books],:BrowseNode=>[nil]},
    "Garden"=>{:SearchIndex=>[:HomeGarden],:BrowseNode=>[nil]},
    
    "Gift Cards"=>{:SearchIndex=>[:GiftCards],:BrowseNode=>[229220]},
    "Grocery"=>{:SearchIndex=>:Grocery,:BrowseNode=>[16310101]},
#    "Gourmet Food"=>{:SearchIndex=>[:GourmetFood],:BrowseNode=>[16310101]},
    "Health Personal Care"=>{:SearchIndex=>[:HealthPersonalCare],:BrowseNode=>[3760901]},           
    #"Hobbies"=>{:SearchIndex=>:DigitalMusic,:BrowseNode=>3760911},
   # "Home  decor "=>{:SearchIndex=>[nil],:BrowseNode=>[251266011]},
    "Home Improvement &  tools" =>{:SearchIndex=>[:Tools],:BrowseNode=>[251266011,228013]},
    #"Industrial"=>:Industrial,
    "Jewelry" =>{:SearchIndex=>[:Jewelry],:BrowseNode=>[3367581]},
     "Kindle Store"=>{:SearchIndex=>[:KindleStore],:BrowseNode=>[133140011]},
     "Kitchen & Dining"=>{:SearchIndex=>[nil],:BrowseNode=>[284507,1055398]},
    "Magazines"=>{:SearchIndex=>[:Magazines],:BrowseNode=>[599858]}, 
    "Miscellaneous"=>{:SearchIndex=>[:Miscellaneous],:BrowseNode=>[nil]},
    "Mobile Apps"=>{:SearchIndex=>[:MobileApps],:BrowseNode=>[2350149011]},
    "MP3 Downloads"=>{:SearchIndex=>[:MP3Downloads],:BrowseNode=>[nil]},
    "Music"=>{:SearchIndex=>[:Music],:BrowseNode=>[5174]} ,
    "Musical Instruments"=> {:SearchIndex=>[:MusicalInstruments],:BrowseNode=>[nil]},
    "Office Products"=>{:SearchIndex=>[:OfficeProducts],:BrowseNode=>[1064954]},
    "Outdoor Living & patio &Lawn & garden"=>{:SearchIndex=>[:OutdoorLiving],:BrowseNode=>[517808]},
    "PC Hardware"=>{:SearchIndex=>[:PCHardware],:BrowseNode=>[nil]},
    "Pet Supplies"=>{:SearchIndex=>[:PetSupplies],:BrowseNode=>[2619533011]},
    "Photo"=>{:SearchIndex=>[:Photo],:BrowseNode=>[nil]},
    "Shoes"=>{:SearchIndex=>[:Shoes],:BrowseNode=>[672123011]}, 
    #"Silver Merchants"=>{:SearchIndex=>:SilverMerchants,:BrowseNode=>3760911}, 
    :Software=>{:SearchIndex=>[:Software],:BrowseNode=>[229534]},
    "Sporting Goods"=>{:SearchIndex=>[:SportingGoods],:BrowseNode=>[3375251]},
    "Software Video Games & Video games"=>{:SearchIndex=>[:VideoGames],:BrowseNode=>[468642]},
    "Toys"=>{:SearchIndex=>[:Toys],:BrowseNode=>[165793011]},
    "VHS"=>{:SearchIndex=>[:VHS],:BrowseNode=>[nil]} ,
    "Video"=>{:SearchIndex=>[:Video],:BrowseNode=>[nil]},
    "Watches"=>{:SearchIndex=>[:Watches],:BrowseNode=>[nil]},
    #"Wireless Accessories"=>{:SearchIndex=>:WirelessAccessories,:BrowseNode=>3760911}
    "Wireless & Accessories"=>{:SearchIndex=>[:Wirelses,:WirelessAccessories],:BrowseNode=>[nil]}
    
    }
    def self.included(base)
      base.send :include, InstanceMethods
     # base.send :extend, ClassMethods
    end
    module InstanceMethods
     def list_search_indexes
       SEARCH_INDEX
    end
    
    end
end
class Array
  def except_nodes(array_string)
    if array_string.is_a?(String)
      self - array_string.to_a
    elsif array_string.is_a?(Array)
     self - array_string
    end 
  end
end

