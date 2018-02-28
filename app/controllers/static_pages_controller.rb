class StaticPagesController < ApplicationController
  def home
  	FlickRaw.api_key = ENV["FLICKR_API_KEY"]
		FlickRaw.shared_secret = ENV["FLICKR_API_SECRET"]

		@user_name = search_params[:user_name]
		if @user_name.nil?
			render 'home'
		else
			begin
				@user = flickr.people.findByUsername(username: @user_name)
				@pics = flickr.photos.search(user_id: @user["id"], extras: "url_s")
			rescue
				flash.now[:danger] = "That user does not exist"
			end
			
			render 'home'
		end
  end

  private
  	def search_params
  		params.permit(:user_name)
  	end

end
