require "faraday"
require "json"

module CocRb
    class << self
             attr_accessor :configuration
    end

    def self.configure
              @configuration ||= Configuration.new
              yield(configuration)
    end

    class Configuration
               attr_accessor :token, :url
      def initialize
               @token = nil
               @url = nil
      end
    end

  class Settings

    def self.get
              @conn = Faraday.new(
              url:"https://api.clashofclans.com" ,
              headers: {
                  'Content-Type' => 'application/json',
                  'Authorization' => "Bearer #{CocRb.configuration.token}"
         }
       )
             rescue => e
             raise "Oops Unexpected error Caught!"
             puts e
  end
end

class Location < Settings
    # This method will get all the location ID including country name and country code.
    def self.get_LocationId(_limit:false, status:false)
            get
            res = @conn.get("v1/locations") do |req|
            req.params[:limit] = _limit if _limit
    end
       if status
             res.status
       else
             val = res.body
             convert = JSON.parse(val)

  end
end

   def self.get_LocationInfo(locationId:, status:false)
             get
             res = @conn.get("v1/locations/#{locationId}")
       if status
              res.status
       else
              val = res.body
              convert = JSON.parse(val)
  end
end


   def self.get_LocationRankClan(locationId:, _limit:false, status:false)
              get
              res = @conn.get("v1/locations/#{locationId}/rankings/clans") do |req|
              req.params[:limit] = _limit if _limit
  end
       if status
              res.status
       else
              val = res.body
              convert = JSON.parse(val)
  end
end

   def self.get_LocationRankPlayer(locationId:, _limit:false, status:false)
              get
              res = @conn.get("v1/locations/#{locationId}/rankings/players") do |req|
              req.params[:limit] = _limit if _limit
  end
        if status
              res.status
        else
              val = res.body
              convert = JSON.parse(val)
  end
end

  def self.get_LocationRankClanVersus(locationId:, _limit:false, status:false)
              get
              res = @conn.get("v1/locations/#{locationId}/rankings/clans-versus") do |req|
              req.params[:limit] = _limit if _limit
  end
      if status
              res.status
      else
              val = res.body
              convert = JSON.parse(val)
  end
end

  def self.get_LocationRankPlayerVersus(locationId:, _limit:false, status:false)
             get
             res = @conn.get("v1/locations/#{locationId}/rankings/players-versus") do |req|
             req.params[:limit] = _limit if _limit
   end
     if status
             res.status
     else
             val = res.body
             convert = JSON.parse(val)
        end
      end
   end
end
