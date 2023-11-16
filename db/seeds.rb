# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'uri'
require 'net/http'

puts 'Destroying existing data ....'
Movie.destroy_all
puts 'Existing data destroyed !'

url = URI("https://tmdb.lewagon.com/movie/top_rated?api_key=%3Cyour_api_key%3E")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = (url.scheme == 'https')

request = Net::HTTP::Get.new(url)
response = http.request(request)

data = JSON.parse(response.body)
data['results'].each do |result|
  Movie.create([title: result['title'], overview: result['overview'], rating: result['vote_average'], poster_url: "https://image.tmdb.org/t/p/w500#{result['poster_path']}"])
  puts "#{result['title']} created !"
end
puts ''
puts 'Finished !'
