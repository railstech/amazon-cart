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
    "Apparel & Accessories"=>{:SearchIndex=>[:Apparel],:BrowseNode=>[1036592],:NarrowBy=>["Subject", "BrandName", "PriceRange", "SpecialSize"]},
    "Appliances"=>{:SearchIndex=>[:Appliances],:BrowseNode=>[nil],},
    "Arts and Crafts"=>{:SearchIndex=>[:ArtsAndCrafts],:BrowseNode=>[2617941011]},
    "Automotive"=>{:SearchIndex=>[:Automotive],:BrowseNode=>[15684181]},
    "Baby"=>{:SearchIndex=>[:Baby],:BrowseNode=>[165796011],:NarrowBy=>["Subject", "BrandName", "PriceRange", "SpecialSize"]},
    "Beauty"=>{:SearchIndex=>[:Beauty],:BrowseNode=>[3760911],:NarrowBy=>["Subject", "BrandName", "PriceRange", "SpecialSize"]},
  #  "Blended"=>:Blended,
    "Books"=>{:SearchIndex=>[:Books],:BrowseNode=>[283155],:NarrowBy=>["Subject"]},
    "DVD"=>{:SearchIndex=>[:DVD],:BrowseNode=>[nil],:NarrowBy=>["Subject"]} ,
    "Digital Music"=>{:SearchIndex=>[:DigitalMusic],:BrowseNode=>[nil]},
    "Electronics & Computers & Accessories"=>{:SearchIndex=>[:Electronics],:BrowseNode=>[172282],:NarrowBy=>["Subject", "BrandName", "PriceRange", "SpecialSize"]},      
    "Foreign Books"=>{:SearchIndex=>[:Books],:BrowseNode=>[nil]},
    "Garden"=>{:SearchIndex=>[:HomeGarden],:BrowseNode=>[nil],:NarrowBy=>["Subject", "BrandName", "PriceRange", "SpecialSize"]},
    
    "Gift Cards"=>{:SearchIndex=>[:GiftCards],:BrowseNode=>[229220]},
    "Grocery"=>{:SearchIndex=>:Grocery,:BrowseNode=>[16310101]},
#    "Gourmet Food"=>{:SearchIndex=>[:GourmetFood],:BrowseNode=>[16310101],:NarrowBy=>["Subject", "BrandName", "PriceRange", "SpecialSize"]},
    "Health Personal Care"=>{:SearchIndex=>[:HealthPersonalCare],:BrowseNode=>[3760901],:NarrowBy=>["Subject", "BrandName", "PriceRange", "SpecialSize"]},           
    "Hobbies"=>{:SearchIndex=>[:Hobbies],:BrowseNode=>[nil]},
   # "Home  decor "=>{:SearchIndex=>[nil],:BrowseNode=>[251266011]},
    "Home Improvement &  tools" =>{:SearchIndex=>[:Tools],:BrowseNode=>[251266011,228013]},
    #"Industrial"=>:Industrial,
    "Jewelry" =>{:SearchIndex=>[:Jewelry],:BrowseNode=>[3367581],:NarrowBy=>["Subject", "BrandName", "PriceRange", "SpecialSize"]},
     "Kindle Store"=>{:SearchIndex=>[:KindleStore],:BrowseNode=>[133140011]},
     "Kitchen & Dining"=>{:SearchIndex=>[:Kitchen],:BrowseNode=>[284507,1055398],:NarrowBy=>["Subject", "BrandName", "PriceRange", "SpecialSize"]},
    "Magazines"=>{:SearchIndex=>[:Magazines],:BrowseNode=>[599858],:NarrowBy=>["Subject"]}, 
    "Miscellaneous"=>{:SearchIndex=>[:Miscellaneous],:BrowseNode=>[nil],:NarrowBy=>["Subject", "BrandName", "PriceRange", "SpecialSize"]},
    "Mobile Apps"=>{:SearchIndex=>[:MobileApps],:BrowseNode=>[2350149011]},
    "MP3 Downloads"=>{:SearchIndex=>[:MP3Downloads],:BrowseNode=>[nil]},
    "Music"=>{:SearchIndex=>[:Music],:BrowseNode=>[5174],:NarrowBy=>["Subject"]} ,
    "Musical Instruments"=> {:SearchIndex=>[:MusicalInstruments],:BrowseNode=>[nil],:NarrowBy=>["Subject", "BrandName", "PriceRange", "SpecialSize"]},
    "Office Products"=>{:SearchIndex=>[:OfficeProducts],:BrowseNode=>[1064954],:NarrowBy=>["Subject", "BrandName", "PriceRange", "SpecialSize"]},
    "Outdoor Living & patio &Lawn & garden"=>{:SearchIndex=>[:OutdoorLiving],:BrowseNode=>[517808]},
    "PC Hardware"=>{:SearchIndex=>[:PCHardware],:BrowseNode=>[nil],:NarrowBy=>["Subject", "BrandName", "PriceRange", "SpecialSize"]},
    "Pet Supplies"=>{:SearchIndex=>[:PetSupplies],:BrowseNode=>[2619533011]},
    "Photo"=>{:SearchIndex=>[:Photo],:BrowseNode=>[nil],:NarrowBy=>["Subject", "BrandName", "PriceRange", "SpecialSize"]},
    "Shoes"=>{:SearchIndex=>[:Shoes],:BrowseNode=>[672123011],:NarrowBy=>["Subject", "BrandName", "PriceRange", "SpecialSize"]}, 
    #"Silver Merchants"=>{:SearchIndex=>:SilverMerchants,:BrowseNode=>3760911}, 
    :Software=>{:SearchIndex=>[:Software],:BrowseNode=>[229534],:NarrowBy=>["Subject", "BrandName", "PriceRange", "SpecialSize"]},
    "Sporting Goods"=>{:SearchIndex=>[:SportingGoods],:BrowseNode=>[3375251],:NarrowBy=>["Subject", "BrandName", "PriceRange", "SpecialSize"]},
    "Software Video Games & Video games"=>{:SearchIndex=>[:VideoGames],:BrowseNode=>[468642],:NarrowBy=>["Subject", "BrandName", "PriceRange", "SpecialSize"]},
    "Toys"=>{:SearchIndex=>[:Toys],:BrowseNode=>[165793011],:NarrowBy=>["Subject", "BrandName", "PriceRange", "SpecialSize"]},
    "VHS"=>{:SearchIndex=>[:VHS],:BrowseNode=>[nil],:NarrowBy=>["Subject"]} ,
    "Video"=>{:SearchIndex=>[:Video],:BrowseNode=>[nil],:NarrowBy=>["Subject"]},
    "Watches"=>{:SearchIndex=>[:Watches],:BrowseNode=>[nil]},
    #"Wireless Accessories"=>{:SearchIndex=>:WirelessAccessories,:BrowseNode=>3760911}
    "Wireless & Accessories"=>{:SearchIndex=>[:Wirelses,:WirelessAccessories],:BrowseNode=>[nil],:NarrowBy=>["Subject"]}
    
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

