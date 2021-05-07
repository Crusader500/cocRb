require "faraday"
require "json"
require "time"

module CocRb

  class << self
            attr_accessor :configuration
    end

    def self.configure
            @configuration ||= Configuration.new
            yield(configuration)
    end

    class Configuration
            attr_accessor :token

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

class GoldPass < Settings

     def self.get_GoldPassInfo(status: false)
            get
            res = @conn.get("v1/goldpass/seasons/current")

     if status
            res.status
     else
            val = res.body

            convert = JSON.parse(val)

            startTime = convert["startTime"]

            endTime = convert["endTime"]

            t = Time.parse(startTime).strftime('%y-%m-%d, %H:%M:%S %p')

            t1 = Time.parse(endTime).strftime('%y-%m-%d, %H:%M:%S %p')

             gp = {
             "startTime" => startTime,
             "endTime" => endTime
             },
             {
             "parsed_startTime" => t,
             "parsed_endTime" => t1
             }.freeze

           end
       end
   end
end
