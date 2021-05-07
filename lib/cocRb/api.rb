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
       url: CocRb.configuration.url ,
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

class ClashApi < Settings
    def self.call_API(status: false)
      get
      res = @conn.get(CocRb.configuration.url)
  if status
    res.status
  else
      val = res.body
      convert = JSON.parse(val)
      end
    end
  end
end
