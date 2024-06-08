require 'faker'
require 'httparty'

# URL de l'API
url = 'https://tmdb.lewagon.com/movie/top_rated'

# Requête à l'API
response = HTTParty.get(url)
movies = response.parsed_response['results']

# Création des films dans la base de données
movies.each do |movie|
  Movie.find_or_create_by!(
    title: movie['title'],
    overview: movie['overview']
  ) do |m|
    m.poster_url = "https://image.tmdb.org/t/p/w500#{movie['poster_path']}"
    m.rating = movie['vote_average']
  end
end

# Ajout de quelques films fictifs avec Faker, en s'assurant de l'unicité
10.times do |i|
  unique_title = "#{Faker::Movie.title} #{i}"
  unique_overview = "#{Faker::Lorem.paragraph} #{i}"
  Movie.create!(
    title: unique_title,
    overview: unique_overview,
    poster_url: Faker::LoremFlickr.image(size: '300x450', search_terms: ['movie']),
    rating: rand(1.0..10.0).round(1)
  )
end

puts 'Movies seeded!'

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
