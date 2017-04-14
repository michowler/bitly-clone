require 'SecureRandom'
#https://github.com/jforaker/Ritly/blob/master/app/models/url.rb
class Url < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration
  validates :long_url, presence: true
  validates :long_url, uniqueness: true
  validate :is_valid_url

	before_create do 
		self.short_url = shorten
	end

	before_create do 
		self.click_count = counter
	end

    def shorten
    # Write a method here
        return ((0..9).to_a + ("a".."z").to_a + ("A".."Z").to_a).sample(7).join
    end

    def counter
    	self.click_count = 0
    end	

    def is_valid_url
    #TODO upgrade validations
   
    	unless !self.long_url.nil? && self.long_url.start_with?("http://", "https://") 
      		errors.add(:long_url, "must start with http:// or https://")
    	end
   
	  end

end


