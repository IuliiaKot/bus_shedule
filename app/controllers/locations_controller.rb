class LocationsController < ApplicationController

  # def index
  #   # a = request.location
  #   @locations = Location.all
  #
  #   #nearloc = Location.near([ 37.76164, -122.50914], 10)
  #
  #   Agency.get_agency
  #   @agency = Agency.all
  #   tag = Agency.find_by_tag("sf-muni")
  #
  #   @routes = Route.get_route_for_agency(tag)
  #   (1..3).each do |i|
  #     tag = Route.find(i)
  #     Stop.get_stops(tag)
  #   end
  #   @stops = Stop.all
  # end
  #
  # def new
  #
  #   @location = Location.new
  #   @stops = Stop.all
  # end
  #
  # def create
  #    @location = Location.new(location_params)
  #    if @location.save
  #      redirect_to @location
  #    else
  #      render 'new'
  #    end
  # end
  #
  # def show
  #   @location = Location.all
  #
  # end
  #
  # private
  # def location_params
  #   params.require(:location).permit(:address)
  # end

end
