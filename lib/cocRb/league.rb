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
             url:"https://api.clashofclans.com",
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

class League < Settings
   # This method gets League ID for all the Leagues.
   def self.get_LeaguesID(_limit:false, status:false)
              get
              res = @conn.get('v1/leagues') do |req|
              req.params[:limit] = _limit if _limit
   end

         if status
              res.status

         else
              val = res.body
              convert = JSON.parse(val)

  end
end
   # This method gets season Info for Legend League, Takes League ID as a parameter.
   #
   # *Paramter Data Type*  => _Integer_
  def self.get_Seasons(leagueId:, _limit:false, status:false)
              get
       if leagueId != 29000022
              puts "Not a valid League id,Seasons are only available for Legend League"
       else
              res = @conn.get("v1/leagues/#{leagueId}/seasons") do |req|
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
       # This method gets Season Rank for Legend League, Takes League ID and Season ID as parameter.
       #
       # *Paramter Data Types*  => _Integer_, _String_
      def self.get_LeagueSeasonRank(leagueId:, seasonId:, _limit:false, status:false)
              get
      if leagueId != 29000022
              puts "Not a valid League id,Seasons are only available for Legend League"
      else
              res = @conn.get("v1/leagues/#{leagueId}/seasons/#{seasonId}") do |req|
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
       # This method gets League Info for a particular league ID.
       #
       # *Paramter Data Type*  => _Integer_
       def self.get_LeagueInfo(leagueId:, status:false)
              get
              res = @conn.get("v1/leagues/#{leagueId}")
       if status
              res.status
       else
              val = res.body
              convert = JSON.parse(val)

    end
end

    # This method gets War League ID.
    def self.get_WarLeagueId(_limit:false, status:false)
             get
             res = @conn.get("v1/warleagues") do |req|
             req.params[:limit] = _limit if _limit
    end

       if status
             res.status
       else
             val = res.body
             convert = JSON.parse(val)
        end
    end
     # This method gets War League Info takes warLeagueId as a paramter.
     #
     # *Paramter Data Type*  => _Integer_
     def self.get_WarLeagueInfo(warLeagueId:, status:false)
             get
             res = @conn.get("v1/warleagues/#{warLeagueId}")
     if status
             res.status
     else
             val = res.body
             convert = JSON.parse(val)
            end
        end
    end
end
