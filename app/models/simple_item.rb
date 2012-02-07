#Monkey patch
require 'hashie'
require 'pry'
module ASIN

  # =SimpleItem
  #
  # The +SimpleItem+ class is a wrapper for the Amazon XML-REST-Response.
  #
  # A Hashie::Mash is used for the internal data representation and can be accessed over the +raw+ attribute.
  #
  class SimpleItem
    def small_image_url
      @raw.SmallImage!.URL || @raw.LargeImage!.URL
    end
   def medium_image_url
      @raw.MediumImage!.URL || @raw.SmallImage!.URL|| @raw.LargeImage!.URL 
   end

   def customer_review_is_present?
    binding.pry
     to_boolean(@raw.CustomerReviews.HasReviews, nil_value = false)
   end

   def customer_review_url
     @raw.CustomerReviews.IFrameURL 
   end

   def to_boolean(value, nil_value = false)
    value.downcase! if value.class == String
    case value
      when "no","false",false, "0", 0
        false
      when "yes","true",true, "1", 1
        true
      when nil
        nil_value
      else
        !!value
      end
    end 
   end
end  
  
