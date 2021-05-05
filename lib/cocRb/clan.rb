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
  class Clans < Settings
    def self.getClans(name:, filterOptions:, filterValue:, _limit: false, status: false)
      get
      options = ["warFrequency", "locationId", "minMembers", "maxMembers", "minClanPoints", "minClanLevel"]
      check = options.include?(filterOptions)
        if check
        count = name.split(/[^-a-zA-Z]/).size
        if count > 2
          res = @conn.get('v1/clans') do |req|
            req.params = { name: name, filterOptions:filterValue}
            req.params[:limit] = _limit if _limit
          end
          if status
            puts res.status
          else
            val = res.body
            convert = JSON.parse(val)
          end
        elsif count == 2
          res = @conn.get('v1/clans') do |req|
            req.params = { name: name, filterOptions:filterValue}
            req.params[:limit] = _limit if _limit
          end
          if status
            puts res.status
          else
            val = res.body
            convert = JSON.parse(val)
          end
        else
          res = @conn.get('v1/clans') do |req|
            req.params = { name: name, filterOptions:filterValue}
            req.params[:limit] = _limit if _limit
          end
          if status
            puts res.status
          else
            val = res.body
            convert = JSON.parse(val)
          end
        end
      else
      puts "Not a valid input option for this method"
end
end

    def self.get_clans_ByTag(tag:, status: false)
      get
      io = tag
      clanTag = io.gsub('#', '%23')
      res = @conn.get("v1/clans/#{clanTag}")
      if status
        puts res.status
      else
        val = res.body
        convert = JSON.parse(val)
      end
    end

    def self.get_clans_ByName(name:, _limit:false, status:false)
      get
      count = name.split(/[^-a-zA-Z]/).size
      if count > 2
        res = @conn.get('v1/clans') do |req|
          req.params = { name: name}
          req.params[:limit] = _limit if _limit
        end
        if status
          puts res.status
        else
          val = res.body
          convert = JSON.parse(val)
        end
      elsif count == 2
        res = @conn.get('v1/clans') do |req|
          req.params = { name: name}
          req.params[:limit] = _limit if _limit
        end
        if status
          puts res.status
        else
          val = res.body
          convert = JSON.parse(val)
        end
      else
        res = @conn.get('v1/clans') do |req|
          req.params = { name: name}
          req.params[:limit] = _limit if _limit
        end
        if status
          puts res.status
        else
          val = res.body
          convert = JSON.parse(val)
        end
end

end

    def self.get_clans_ByLocationID(id:, _limit: false, status:false)
      get
      res = @conn.get('v1/clans') do |req|
        req.params = { locationId: id}
        req.params[:limit] = _limit if _limit
      end

      if status
        puts res.status
      else
        val = res.body
        convert = JSON.parse(val)
      end

    end

    def self.get_clans_ByMinClanLevel(clanLevel:, _limit: false, status: false)
      get
      res = @conn.get('v1/clans') do |req|
        req.params = { minClanLevel: clanLevel }
        req.params[:limit] = _limit if _limit
      end
      if status
        puts res.status
      else
        val = res.body
        convert = JSON.parse(val)
      end


    end

  def self.get_clan_Members(tag:, _limit:false, status:false)
       get
      io = tag
      tag1 = io.gsub('#', '%23')
      res = @conn.get("v1/clans/#{tag1}/members") do |req|
         req.params[:limit] = _limit if _limit
      end

      if status
        puts res.status
      else
          val = res.body
          convert = JSON.parse(val)
      end

end

def self.get_detailed_ClanMembers(tag:, _limit: false, status: false)
   get
   io = tag
   tag1 = io.gsub('#', '%23')
   res = @conn.get("v1/clans/#{tag1}/members") do |req|
      req.params[:limit] = _limit if _limit
   end

   if status
   puts res.status
 else
val = res.body
convert = JSON.parse(val)
each = convert["items"].map {|m| m["tag"]}

extract = each.map {|x| x.gsub /^#/, '%23'}

resp = extract.map do |ext|
  anotheres = @conn.get("v1/players/#{ext}") do |req|
    req.params[:limit] = _limit if _limit
  end
  response = anotheres.body
  val = JSON.parse(response)
end
end
end

end
end
