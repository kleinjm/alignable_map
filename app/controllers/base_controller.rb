class BaseController < ApplicationController
  require 'open-uri'

  def index
    # fetch the business data and place it into the wrapper object
    json = JSON.load(open("https://alignableweb-dev2.herokuapp.com/v1/businesses?api_key=#{ENV['BUSINESS_API_KEY']}"))
    @businesses = []
    json["entries"].each do |entry|
      @businesses << Business.new(
        id: entry["id"], 
        name: entry["name"], 
        latitude: entry["latitude"], 
        longitude: entry["longitude"],
        address1: entry["address1"],
        address2: entry["address2"]
      )
    end

    # build the hash that will be passed to the JS method for map rendering
    @hash = Gmaps4rails.build_markers(@businesses) do |business, marker|
      marker.lat business.latitude
      marker.lng business.longitude
      marker.title business.id.to_s
    end
  end

  def detail
    # fetch the business JSON for the business with the given id
    id = params[:id]
    business = JSON.load(open("https://alignableweb-dev2.herokuapp.com/v1/businesses/#{id}?api_key=#{ENV['BUSINESS_API_KEY']}"))
    render json: business
  end
end
