class StopsController < ApplicationController
  def index
    @agency = Agency.all
    @routes = Route.all
    @stops = Stop.all
  end

  def new
  end

  def create
    title = params["stop"].split(",")[0]
    lat = params["stop"].split(",")[1].to_f
    lng = params["stop"].split(",")[2].to_f
    #stop = Stop.find_by_tag(params)
    @res ={}
    @nearloc = Stop.near([lat, lng], 0.2)
    @nearloc.each do |loc|
      tag = Route.find_by_id(loc["route_id"])
      a  = Stop.get_time_for_stop([tag,loc["tag"].to_i])

      @res[loc["title"]+rand(1..100).to_s] = a
    end
  end
end
