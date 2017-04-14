get '/' do
	@urls = Url.last(5).reverse
  erb :"static/index"
end

# i.e. /urls?long_url=google.com
post '/urls' do
  # add url to database
  @url = Url.new(long_url: params[:long_url])

  if @url.save 
  	# redirect "/"
    return @url.to_json

  else
    status 400
    return @url.errors.full_messages.join('.')

     # @err = url.errors[:long_url] #errros is an array but errors.full_messages is a hash
     # @urls = Url.last(3).reverse
     # erb :"static/index"
  end
end

# # i.e. /q6bda
get '/:short_url' do
  # redirect to appropriate "long" URL
  
  @url = Url.find_by(short_url: params[:short_url])
  @url.click_count += 1
  @url.save!

  redirect "#{@url.long_url}"

end



