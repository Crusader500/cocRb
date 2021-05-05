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
  class Player < Settings
   def self.getPlayerBy_Tag(tag:, status: false)
     get
     io = tag
     tag1 = io.gsub('#', '%23')
     res = @conn.get("v1/players/#{tag1}")

     if status
       res.status
    else
    val = res.body
    convert = JSON.parse(val)
     end
   end 


  def self.verifyPlayer(tag:, playertoken:)
    get
    io = tag
    tag1 = io.gsub('#', '%23')
    res = @conn.post("v1/players/#{tag1}/verifytoken") do |req|
     req.body = {
       token: playertoken
     }.to_json
    end

    val = res.body
    convert = JSON.parse(val)

end
  end
end
