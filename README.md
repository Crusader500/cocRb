![coc Rb](https://media.discordapp.net/attachments/662341843861766164/840316348554412042/unknown-removebg-preview.png)

# CocRb

Welcome everyone to your Ruby Gem CocRb. By using this gem you can easily interact with the Game API of Clash of Clans without using any external gems to call this service.



## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cocRb'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install cocRb


# Links

* [Full Documentation](https://www.rubydoc.info/gems/cocRb/1.1.5)
* [GEM](https://rubygems.org/gems/cocRb)



## Optional Paramters

 * **status**: This is default set to false on every method except *verify_PlayerByToken* method. The method Parameter takes any String as an arguement.
  **Returns => Status Code for a method**

 * **_limit**: This is also set to false. You can *limit* any request where limit parameter is available for a method.
  **Paramter Data Type => Integer**


## Method Options

### Filter Options

* warFrequency
* locationId
* minMembers
* maxMembers
* minClanPoints
* minClanLevel

### Team Input Options

* clan
* opponent

## Status Codes

* **200**: Successful Response.
* **400**: Client provided incorrect parameters for the request.
* **403**: Access denied, either because of missing/incorrect credentials or used API token does not grant access to the requested resource.
* **404**: Resource was not found.
* **429**: Request was throttled, because amount of requests was above the threshold defined for the used API token.
* **500**: Unknown error happened when handling the request.
* **503**: Service is temporarily unavailable because of maintenance.
* **504**: Request Timeout.


## Usage
CocRb Gem is categorized with [Classes](https://www.tutorialspoint.com/ruby/ruby_classes.htm) and [Methods](https://www.tutorialspoint.com/ruby/ruby_methods.htm) as below down you can see but before accessing any of those we have to set **Configuration** in order to setup the Authorization for accessing the [Clash of Clans API](https://developer.clashofclans.com/#) so to do that we have set **Configure** block and inside that block we have configured our **TOKEN** and the **URL**.


```ruby
token = <Your_Token>
requestUrl = <Your_Url>

CocRb.configure do |config|
     config.token = token
     config.url = requestUrl
end
```
After done setting up the Authorization we now need to call the API as you can see down below we called the API using **call_API** method now just before that line we have set the class **ClashApi** by name_spacing with **CocRb** [Module](https://www.tutorialspoint.com/ruby/ruby_modules.htm).

**Note:** All the data that we will get from the API response was in [JSON](https://jsonapi.org/) but since you are using this gem all of the responses has been **parsed** to Ruby [Hashes](https://www.tutorialspoint.com/ruby/ruby_hashes.htm) so that its get easy for you to access the data.


```ruby
set_Class = CocRb::ClashApi

response = set_Class.call_API

puts response

# data from the API in Ruby Hashes...
```

The API can also be called without using the **URL** in the Configuration block the way you can do is shown down below. As you can we have almost followed the same procedure like we did before just changed few things those are we have removed the *config.url* line, We now have called a new class and a method. This method now takes two parameters one is your [Player Tag](https://clashofclans.fandom.com/wiki/Player_Profile#:~:text=The%20player%27s%20name%20and%20player,they%20are%20in%20a%20clan) and another thing is your [Player API Token](eddit.com/r/ClashOfClans/comments/apebtq/ask_what_is_an_api_token/) which you will find **In-Game Settings**.



```ruby

CocRb.configure do |config|
     config.token = token
end

set_var = CocRb::Player   

response = set_var.verify_PlayerByToken(tag: "#PG8RLGQ2", playertoken: "7jeagw4c")

# Response => {"tag"=>"#PG8RLGQ2", "token"=>"7jeagw4c", "status"=>"ok"}

```

## Support

* If you need any help understanding the Library, you can join our [Discord Server](https://discord.gg/Eaja7gJ)
* OR You can create a new Issue on this Repo.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
