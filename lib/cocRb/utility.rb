require "faraday"

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


  class Check < Settings
       # This method gets headers for a particular endpoint. Takes the requestUrl in the configuration block.
      def self.get_Headers
           get
           res = @conn.get(CocRb.configuration.url)
           res.headers
    end
  end
end
