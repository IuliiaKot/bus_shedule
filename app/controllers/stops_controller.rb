class StopsController < ApplicationController
  def index

    if Agency.count == 0
      Agency.get_agency
    end
    if Route.count == 0
      tag = Agency.find_by_tag("sf-muni")
      Route.get_route_for_agency(tag)
    end
     if Stop.count == 0
       @routes.each do |route|
         Stop.get_stops(route)
       end
     end
     @agency = Agency.all
     @routes = Route.all
     @stops = Stop.all

     a = params
  end

  def new
  end

  def create
    title = params["stop"].split(",")[0]
    lat = params["stop"].split(",")[1].to_f
    lng = params["stop"].split(",")[2].to_f
    @stops = Stop.all
    #stop = Stop.find_by_tag(params)
    @res ={}
    @nearloc = @stops.near([lat, lng], 0.1)
    @nearloc.each do |loc|
      tag = Route.find_by_id(loc["route_id"])
      @res[loc["title"]] = Stop.get_time_for_stop([tag,loc["tag"].to_i])
    end
   end
end
#
# def create
#   title = params["stop"].split(",")[0]
#   lat = params["stop"].split(",")[1].to_f
#   lng = params["stop"].split(",")[2].to_f
#   @stops = Stop.all
#   #stop = Stop.find_by_tag(params)
#   @res ={}
#   @nearloc = Stop.near([lat, lng], 0.1)
#   @nearloc.each do |loc|
#     tag = Route.find_by_id(loc["route_id"])
#     a  = Stop.get_time_for_stop([tag,loc["tag"].to_i])
# f
#     @res[loc["title"]] = a
#   end
#  end



####better solution
# def create
#   title = params["stop"].split(",")[0]
#   lat = params["stop"].split(",")[1].to_f
#   lng = params["stop"].split(",")[2].to_f
#   @stops = Stop.all
#   #stop = Stop.find_by_tag(params)
#   @res ={}
#   @nearloc = Stop.near([lat, lng], 0.1)
#   stops = []
#   @nearloc.each do |loc|
#     tag = Route.find_by_id(loc["route_id"])
#     params = [tag,loc["tag"].to_i]
#     stops << [params[0]["tag"], params[1]].join("|")
#     #a  = Stop.get_time_for_stop([tag,loc["tag"].to_i])
#   #  @res[loc["title"]] = a
#   end
#   Stop.get_time_for_stop(stops.join("&stops="))
#   gjfkgj
#  end
