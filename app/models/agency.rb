class Agency < ActiveRecord::Base
  has_many :routes


  def self.get_agency
    response = HTTParty.get("http://webservices.nextbus.com/service/publicXMLFeed?command=agencyList")

    response.parsed_response["body"]["agency"].each do |info|
      if Agency.find_by_tag(info["tag"]).nil?
        Agency.create(title: info["title"], tag: info["tag"])
      end
    end
  end
end
