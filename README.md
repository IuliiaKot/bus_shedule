# bus_shedule
Deployed version on Heroku: https://peaceful-chamber-1451.herokuapp.com/

The goal of this service gives real-time departures time for public transportation in San Francisco. The app also should geolocalize the user. If  this is not possible, a user ca choose location from list.

The data are collected directly from the NextBus API in XML, variously using HTTParty. All information about Agency, Route and stops store in database. 

###Front-end

    Used a basic CSS framework Bootstrap
    Added a jQuery plugin (Chosen) to make station selection easier
    Using browser's geolocation api to determine user's location.
    
###Back-end

    Ruby on Rails
    Sqlite3(development)
    PostgreSQL(production)
