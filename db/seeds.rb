# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  Agency.destroy_all
  Route.destroy_all
  Stop.destroy_all

   Agency.get_agency
   Route.get_route_for_agency(Agency.find_by_tag("sf-muni"))
   Route.all.each do |r|
     Stop.get_stops(r)
  end
