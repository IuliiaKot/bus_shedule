class Route < ActiveRecord::Base
  belongs_to :agency
  has_many :stops

  def self.get_route_for_agency(agency)
    response = HTTParty.get("http://webservices.nextbus.com/service/publicXMLFeed?command=routeList", :query => {:a =>agency.tag})
    response.parsed_response["body"]["route"].each do |info|
      if agency.routes.find_by_tag(info["tag"]).nil?
        agency.routes.create(title: info["title"], tag: info["tag"])
      end
    end
  end
end
