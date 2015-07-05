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
     @stops = Stop.select("*").group("title")
     a = params
     #@lat_lng = cookies[:lat_lng].split("|")
    #  @lat_lng = ["37.7606","-122.5041"]
    # check_lat_lng(@lat_lng)
  end

  def check_lat_lng(lat_lng, address)
    if lat_lng.empty?
      @message = "Sorry, we can not find your location. Select location from the list"
    else
      @res ={}
      @nearloc = @stops.near([lat_lng[0].to_f, lat_lng[1].to_f], 0.1)
      @nearloc.each do |loc|
        tag = Route.find_by_id(loc["route_id"])
        @res[loc["title"]] = Stop.get_time_for_stop([tag,loc["tag"].to_i])
        @message = "Stops near " + address
      end
     end
     if @res.empty?
       @message = "We can not find any stops near you. Select location from the list"
     else
       @message = ""
     end
  end

  def new
  end

  def create
    @message
    @location = []
    tmps = []
    flag = false
    address = Geocoder.address([params[:latitude], params[:longitude].to_f])
    @stops  = Stop.select("*").group("title")

    @lat_lng = [params[:latitude], params[:longitude].to_f]
    check_lat_lng(@lat_lng, address)
    if @lat_lng.empty? || @res.empty?
      title = params["stop"].split(",")[0]
      lat = params["stop"].split(",")[1].to_f
      lng = params["stop"].split(",")[2].to_f
      @stops_all = Stop.all
      @res = []
      @nearloc = @stops_all.near([lat, lng], 0.1)
      @nearloc.each do |loc|
        tag = Route.find_by_id(loc["route_id"])
        tmp = Stop.get_time_for_stop([tag,loc["tag"].to_i])
        next if tmp.length == 0
        @res << {:route => tag["title"], :title => loc["title"], :time => tmp}
        if @location.length > 0
          @location.each do |arr|
            if (arr.include?(loc[:latitude]) || arr.include?(loc[:longitude]))
              arr[0] += "|" + [[tag["title"],loc["title"], tmp.last]].join("|")
              flag = true
            end
          end
          if flag
            break
          else
            @location << [[tag["title"],loc["title"], tmp.last].join("|"), loc[:latitude], loc[:longitude]]
          end
        else
          @location << [[tag["title"],loc["title"], tmp.last].join("|"), loc[:latitude], loc[:longitude]]
        end
      end
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
