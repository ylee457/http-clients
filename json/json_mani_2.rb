# JSON Parsing example
require "json"

string = '{"desc":{"someKey":"someValue","anotherKey":"value"},"main_item":{"stats":{"a":8,"b":12,"c":10}}}'
parsed = JSON.parse(string) # returns a hash
p parsed
p parsed["desc"]["someKey"]
p parsed["main_item"]["stats"]["a"]

# Read JSON from a file, iterate over objects
file = open("data/shops.json")
json = file.read

parsed = JSON.parse(json)
p parsed
p parsed["shop"]
p parsed["shop"]["id"]


# Read JSON from a file, iterate over objects
file = open("data/shops-2.json")
json = file.read

parsed = JSON.parse(json)
p parsed
#p parsed["shop"]
#p parsed["shop"]["id"]


# array of shop
#parsed["shop"].each do |shop|
parsed.each do |i|
  p i["shop"]["id"]
  p i["shop"]["Name"]
  p "========================"
end