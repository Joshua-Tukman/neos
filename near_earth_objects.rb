require 'faraday'
require 'figaro'
require 'pry'
# Load ENV vars via Figaro
Figaro.application = Figaro::Application.new(environment: 'production', path: File.expand_path('../config/application.yml', __FILE__))
Figaro.load

class NearEarthObjects
  attr_reader :parsed_astroids_data

  def initialize(date)
    conn = Faraday.new(
      url: 'https://api.nasa.gov',
      params: { start_date: date, api_key: ENV['nasa_api_key']}
    )
    astroids_list_data = conn.get('/neo/rest/v1/feed')
    @parsed_astroids_data = JSON.parse(astroids_list_data.body, symbolize_names: true)[:near_earth_objects][:"#{date}"]
  end

  def largest_astroid_diameter_feet
    max_astroid = parsed_astroids_data.map do |astroid|
      astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i
    end
    "#{max_astroid.max} feet"
  end

  def biggest_astroid
    biggest = {}
    biggest[:diameter] ||= 0
    formatted_astroid_data.each do |astroid|
      biggest = astroid if astroid[:diameter].to_i > biggest[:diameter].to_i
    end
    biggest
  end

  def total_number_of_astroids
    parsed_astroids_data.count
  end

  def formatted_astroid_data
    parsed_astroids_data.map do |astroid|
      {
        name: astroid[:name],
        diameter: "#{astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i} ft",
        miss_distance: "#{astroid[:close_approach_data][0][:miss_distance][:miles].to_i} miles"
      }
    end
  end
  
end
