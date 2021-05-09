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

  class Clan < Settings
       # This method gets clan according to clan filter option. Takes name, filterOptions and filterValue as a parameter.
       #
       # If you want to know about _filterOptions_ please check the Github README page for that.
       #
       # Paramter Data Types => _String_, _String_, _Integer_

       def self.get_FiltredClan(name:, filterOptions:, filterValue:, _limit: false, status: false)
              get

              options = ["warFrequency", "locationId", "minMembers", "maxMembers", "minClanPoints", "minClanLevel"]

              check = options.include?(filterOptions)
        if check
              count = name.split(/[^-a-zA-Z]/).size
        if count > 2
              res = @conn.get('v1/clans') do |req|

              req.params = { name: name, filterOptions: filterValue }

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

             req.params = { name: name, filterOptions: filterValue }

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

             req.params = { name: name, filterOptions: filterValue }

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
    # This method gets Clan Information, Takes tag as a parameter.
    #
    # Paramter Data Type => _String_
    def self.get_ClanByTag(tag:, status: false)
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
    # This method gets Clans by name, Takes name as a parameter.
    #
    # Paramter Data Type => _String_
    def self.get_ClanByName(name:, _limit: false, status: false)
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
     # This method gets clan by Location ID. Takes Location ID as a parameter.
     #
     # Paramter Data Type => _Integer_
     def self.get_ClanByLocationID(id:, _limit: false, status:false)
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
    # This method gets clan by minimum Clan Level. Takes clan level as a parameter.
    #
    # Paramter Data Type => _Integer_
    def self.get_ClanByMinClanLevel(clanLevel:, _limit: false, status: false)
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
     # This method gets clan members. Takes clan tag as a parameter.
     #
     # Paramter Data Type => _String_
     def self.get_ClanMembers(tag:, _limit:false, status:false)
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
       # This method gets detailed clan members. Takes clan tag as a parameter.
       #
       # Note: _This method might take 1-2 min time to get execute depending on the data you are requesting_
       #
       # Paramter Data Type => _String_
       def self.get_DetailedClanMembers(tag:, _limit: false, status: false)
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
