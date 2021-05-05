require 'faraday'
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
class League < Settings
def self.getLeaguesID(_limit:false, status:false)
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

def self.getSeasons(leagueId:, _limit:false, status:false)
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

def self.getLeague_SeasonRank(leagueId:, seasonId:, _limit:false, status:false)
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
