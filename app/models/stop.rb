class Stop < ActiveRecord::Base
  validates :tag, uniqueness: { scope: :route_id }

  belongs_to :route

  geocoded_by :title

  after_validation :geocode

  def self.get_time_for_stop(route)
    result = []
    response = HTTParty.get("http://webservices.nextbus.com/service/publicXMLFeed?command=predictions&a=#{route[0].agency.tag}&r=#{route[0].tag}&s=#{route[1]}")

    if response.parsed_response["body"]["predictions"]["direction"]
       response.parsed_response["body"]["predictions"]["direction"].each do |info, value|
        if info == "prediction" and value.kind_of?(Array)
          value.each do |time|
              result << time["minutes"]
          end
        elsif info == "prediction"
          result << value["minutes"]
        else
          result << value
        end
       end
    else
      return []
    end
    return result #<< response.parsed_response["body"]["predictions"]["direction"]["title"]
  end

  def self.get_stops(route)

    response = HTTParty.get("http://webservices.nextbus.com/service/publicXMLFeed?command=routeConfig&a=#{route.agency.tag}&r=#{route.tag}")

    response.parsed_response["body"]["route"]["stop"].each do |info|
        route.stops.create(title: info["title"], code: info["stopId"], latitude: info["lat"],
                          longitude: info["lon"], tag: info["tag"])
    end

  end
end
