require "faraday"
require "time"
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

  class ClanWar < Settings
      # This methods gets the current warLog for a clan, Takes clan tag as a paramter
      #
      # Paramter Data Type => _String_
      def self.get_WarLog(tag:, _limit:false, status: false)
            get
            io = tag
            tag = io.gsub('#', '%23')
            res = @conn.get("v1/clans/#{tag}/warlog") do |req|
            req.params[:limit] = _limit if _limit
    end

    if status
            puts res.status
    else
            val = res.body
            convert = JSON.parse(val)
       end
    end
      # This method gets information about current on-going war,Takes tag as a paramter
      #
      # Paramter Data Type => _String_
      def self.get_ClanWar(tag:, status: false)
            get
            io = tag
            tag = io.gsub('#', '%23')
            res = @conn.get("v1/clans/#{tag}/currentwar")

       if status
            puts res.status
       else
            val = res.body

            convert = JSON.parse(val)
       end
    end
       # This method gets the members that are in war. In Descending to Ascending TH order. Takes tag as a paramter and teamInput.
       #
       # Note: _The team Input options can be found in Github README._
       #
       # Paramter Data Types => _String_
       def self.get_ClanWarMembers(tag:, teamInput:, status: false)
            get
            teamInput_Options = ["clan", "opponent"]

            check = teamInput_Options.include?(teamInput)

        if check == false
            puts 'Not a valid teamInput Option'
        elsif check == true
            io = tag
            tag = io.gsub('#', '%23')
            res = @conn.get("v1/clans/#{tag}/currentwar")

        if status
            puts res.status
        else
            val = res.body

            convert = JSON.parse(val)

            getClan_War_Members = convert[teamInput]['members']

            hash = getClan_War_Members.sort_by { |s| s['townhallLevel'] }

            sort = hash.sort_by { |_k, v| v }.reverse

         end
       end
    end
      # This method gets all the timings for on-going war in UTC Time Zone, Takes tag as a paramater
      #
      # Note: _This method will also return the War Times in parsed Format_
      #
      # Paramter Data Type => _String_
      def self.get_WarTime(tag:, status: false)
            get
            io = tag
            tag = io.gsub('#', '%23')
            res = @conn.get("v1/clans/#{tag}/currentwar")
      if status
            puts res.status
      else
            val = res.body

            convert = JSON.parse(val)

            time = convert["preparationStartTime"]

            time2 = convert["startTime"]

            time3 = convert["endTime"]

            t = Time.parse(time).strftime('%y-%m-%d, %I:%M:%S %p')
            t1 = Time.parse(time2).strftime('%y-%m-%d, %I:%M:%S %p')
            t2 = Time.parse(time3).strftime('%y-%m-%d, %I:%M:%S %p')

            warTimes = {
               "preparationStartTime" => time,
               "startTime" => time2,
               "endTime" => time3
            },
            {
               "parsed_preparationStartTime" => t,
               "parsed_startTime" => t1,
               "parsed_endTime" => t2
            }.freeze
      end
   end
end

  class ClanWarLeague < Settings
      # This method gets Clan War League Group, Takes tag as a paramter.
      #
      # Paramter Data Type => _String_
      def self.get_ClanWarLeagueGroup(tag:,status: false)
            get
            io = tag

            tag = io.gsub('#', '%23')

            res = @conn.get("v1/clans/#{tag}/currentwar/leaguegroup")

    if status
            res.status
    else
            val = res.body
            convert = JSON.parse(val)
    end
  end
      # This method only returns the filtred items [tag, name,ClanLevel,badgeUrls] from Clan War League Group Endpoint. Takes tag as a paramter
      #
      # Paramter Data Type => _String_
     def self.get_ClanWarLeagueClanItems(tag:,status: false)
            get
            io = tag
            tag = io.gsub('#', '%23')

            res = @conn.get("v1/clans/#{tag}/currentwar/leaguegroup")

      if status
            res.status
      else
            parse = res.body

            convert = JSON.parse(parse)

            clans = convert['clans']

            items_name = clans.map { |n| n['name'] }

            items_tag = clans.map { |t| t['tag'] }

            items_clanLevel = clans.map { |c| c['clanLevel'] }

            items_badgeUrls = clans.map { |b| b['badgeUrls'] }

            clanItems = {
                     'tag' => items_tag[0],
                     'name' => items_name[0],
                     'clanLevel' => items_clanLevel[0],
                     'badgeUrls' => items_badgeUrls[0]
                      },
                      {
                      'tag' => items_tag[1],
                      'name' => items_name[1],
                      'clanLevel' => items_clanLevel[1],
                      'badgeUrls' => items_badgeUrls[1]
                      },
                      {
                      'tag' => items_tag[2],
                      'name' => items_name[2],
                      'clanLevel' => items_clanLevel[2],
                      'badgeUrls' => items_badgeUrls[2]
                      },
                      {
                      'tag' => items_tag[3],
                      'name' => items_name[3],
                      'clanLevel' => items_clanLevel[3],
                      'badgeUrls' => items_badgeUrls[3]
                      },
                      {
                      'tag' => items_tag[4],
                      'name' => items_name[4],
                      'clanLevel' => items_clanLevel[4],
                      'badgeUrls' => items_badgeUrls[4]
                      },
                      {
                      'tag' => items_tag[5],
                      'name' => items_name[5],
                      'clanLevel' => items_clanLevel[5],
                      'badgeUrls' => items_badgeUrls[5]
                      },
                      {
                      'tag' => items_tag[6],
                      'name' => items_name[6],
                      'clanLevel' => items_clanLevel[6],
                      'badgeUrls' => items_badgeUrls[6]
                      },
                      {
                      'tag' => items_tag[7],
                      'name' => items_name[7],
                      'clanLevel' => items_clanLevel[7],
                      'badgeUrls' => items_badgeUrls[7]
                      }.freeze

       end
    end
    # This method returns the WarTags for all the Groups. Takes tag as a paramter.
    #
    # Paramter Data Type => _String_
    def self.get_WarTags(tag:, status:false)
          get

          io = tag

          tag = io.gsub('#', '%23')

          res = @conn.get("v1/clans/#{tag}/currentwar/leaguegroup")

    if status
          res.status
    else
          val = res.body

          convert = JSON.parse(val)

          rounds = convert['rounds']

      end
   end
    # This method gets info for a particular War, Takes WarTag as a Paramter
    #
    # Paramter Data Type => _String_
    def self.get_ClanWarLeagueWars(warTag:, status:false)
          get
          io = warTag

          tag = io.gsub('#', '%23')

          res = @conn.get("v1/clanwarleagues/wars/#{tag}")

    if status
          res.status
    else
          val = res.body
          convert = JSON.parse(val)
       end
    end
    # This method gets all the timings for on-going Clan War League in UTC Time Zone, Takes tag as a paramater
    #
    # Note: _This method will also return the War Times in parsed Format_
    #
    # Paramter Data Type => _String_
    def self.get_ClanWarLeagueWarTimes(warTag:, status: false)
         get
         io = warTag

         tag = io.gsub('#', '%23')

         res = @conn.get("v1/clanwarleagues/wars/#{tag}")

    if status
         res.status
    else
         val = res.body
         convert = JSON.parse(val)

         prepStartTime = convert["preparationStartTime"]

         startTime = convert["startTime"]

         endTime = convert["endTime"]

         parsed_preparationStartTime = Time.parse(prepStartTime).strftime('%y-%m-%d, %I:%M:%S %p')

         parsed_startTime = Time.parse(startTime).strftime('%y-%m-%d, %I:%M:%S %p')

         parsed_endTime = Time.parse(endTime).strftime('%y-%m-%d, %I:%M:%S %p')

         times = {
           "preparationStartTime" => prepStartTime,
           "startTime" => startTime,
           "endTime" => endTime
         },
         {
           "parsed_preparationStartTime" => parsed_preparationStartTime,
           "parsed_startTime" => parsed_startTime,
           "parsed_endTime" => parsed_endTime
         }
         end
      end
   end
end
