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
     @stops = Stop.select("distinct title").order("title")
     a = params
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


  def find_index(location, lan_lng)
    idx = -1
    location.each_with_index do |arr,index|
      if (arr.include?(lan_lng.first) || arr.include?(lan_lng.last))
        idx =  index
      end
    end
    idx
  end

  def group_location_for_marks(location, params)
    if location.empty?
       location << params
     else
          idx = find_index(location, params[-2..-1])
       if  idx != -1
           location[idx][0] += "|" + params.first
       else
           location << params
       end
     end
     location
  end

  def create

    @message
    @location = []
    address = Geocoder.address([params[:latitude], params[:longitude].to_f])
    @stops = Stop.select("distinct title").order("title")
    @lat_lng = [params[:latitude], params[:longitude].to_f]
    check_lat_lng(@lat_lng, address)
    if @lat_lng.empty? || @res.empty?
      lat_lng = Stop.select('latitude, longitude').where('title =?',params["stop"])
      title = params["stop"]
      lat = lat_lng.first[:latitude]
      lng = lat_lng.first[:longitude]
      @res = []
      @res_s = Hash.new()
      @nearloc = Stop.near([lat, lng], 0.1)
      @nearloc.each do |loc|

        tag = Route.find_by_id(loc["route_id"])
        tmp = Stop.get_time_for_stop([tag,loc["tag"].to_i])
        next if tmp.length == 0
        @res << {:route => tag["title"], :title => loc["title"], :time => tmp}
        if @res_s.has_key?(loc["title"])
          @res_s[loc["title"]] << [tag["title"],tmp].flatten
        else
          @res_s[loc["title"]] = [[tag["title"],tmp].flatten]
        end

        @location = group_location_for_marks(@location, [[tag["title"].concat('('+tmp[-1].last+')'),loc["title"], tmp[-2]].join("|"), format("%.4f",loc[:latitude]).to_f, format("%.4f",loc[:longitude]).to_f])
       end
     end
   end
end
