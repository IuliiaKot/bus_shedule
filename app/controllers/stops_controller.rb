class StopsController < ApplicationController
  def index

     Agency.get_agency
     @agency = Agency.all
     tag = Agency.find_by_tag("sf-muni")

     @routes = Route.get_route_for_agency(tag)
     @routes = Route.all
     if Stop.count == 0
       @routes.each do |i|
         tag = Route.find(i)
         Stop.get_stops(tag)
       end
     end
     @stops = Stop.all
     a = params

  end

  def new
  end

  def create
  #   title = params["stop"].split(",")[0]
  #   lat = params["stop"].split(",")[1].to_f
  #   lng = params["stop"].split(",")[2].to_f
  #   @stops = Stop.all
  #   #stop = Stop.find_by_tag(params)
  #   @res ={}
  #   @nearloc = Stop.near([lat, lng], 0.2)
  #   @nearloc.each do |loc|
  #     tag = Route.find_by_id(loc["route_id"])
  #     a  = Stop.get_time_for_stop([tag,loc["tag"].to_i])
  #
  #     @res[loc["title"]] = a
  #   end
   end
end
