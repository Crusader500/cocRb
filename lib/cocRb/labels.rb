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
class Label < Settings
def self.getLabel_Player(_limit:false, status:false)
  get
  res = @conn.get("v1/labels/players") do |req|
     req.params[:limit] = _limit if _limit
  end

  if status
    res.status
  else
    val = res.body
    convert = JSON.parse(val)
  end


end

def self.getLabel_Clan(_limit:false, status:false)
  get
  res = @conn.get("v1/labels/clans") do |req|
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
