require_relative 'cocRb/clan'
require_relative 'cocRb/utility'
require_relative 'cocRb/api'
require_relative 'cocRb/clanWar'
require_relative 'cocRb/gp'
require_relative 'cocRb/labels'
require_relative 'cocRb/league'
require_relative 'cocRb/loactions'
require_relative 'cocRb/player'
require 'faraday'
require 'time'
require "json"

 token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjA4M2E3NWQ4LTE3NGMtNDBmZC1hZjdlLWE1MGVmODEyZDU3ZiIsImlhdCI6MTU5NzIyMDQxOSwic3ViIjoiZGV2ZWxvcGVyL2Q1NWNjNDdhLTBmYjUtNDM5Yi00N2Q2LWFkZTIyMzIwMzJhYSIsInNjb3BlcyI6WyJjbGFzaCJdLCJsaW1pdHMiOlt7InRpZXIiOiJkZXZlbG9wZXIvc2lsdmVyIiwidHlwZSI6InRocm90dGxpbmcifSx7ImNpZHJzIjpbIjEwMy42MC4xNzUuNjMiXSwidHlwZSI6ImNsaWVudCJ9XX0.0r0WB3cL6rVco9DqFMnOG4s-g1sroQebE69iUHSXYepzwSc5ZDy1e4qstvAN_fOu-fN9cg37NmsAdv_elVZWpg"

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
