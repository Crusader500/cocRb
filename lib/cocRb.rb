require_relative './cocRb/clan'
require_relative './cocRb/utility'
require_relative './cocRb/api'
require_relative './cocRb/clanWar'
require_relative './cocRb/gp'
require_relative './cocRb/labels'
require_relative './cocRb/league'
require_relative './cocRb/location'
require_relative './cocRb/player'
require 'faraday'
require 'time'
require "json"

CocRb.configure do |config|
     config.token = token
end

conn = CocRb::Player

get = conn.getPlayerBy_Tag(tag: "#8LR0RUGJU", status: "check_status")

if get == 503
puts "The Server is under Maintenance, Try again later."
else
module CocRb
end
end
