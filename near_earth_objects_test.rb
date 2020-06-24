require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative 'near_earth_objects'

class NearEarthObjectsTest < Minitest::Test

  def test_it_exists
    neos = NearEarthObjects.new('2019-03-30')
  end

  def test_it_returns_array_of_neos
    neos = NearEarthObjects.new('2019-03-30')

    expected = {:links=>{:self=>"http://www.neowsapp.com/rest/v1/neo/3840858?api_key=UJ8Mfto55bt0FgwYnJY8JPEdS8e2eFWOFprATVbG"}, :id=>"3840858",
                :neo_reference_id=>"3840858", :name=>"(2019 GD4)", :nasa_jpl_url=>"http://ssd.jpl.nasa.gov/sbdb.cgi?sstr=3840858",
                :absolute_magnitude_h=>27.5, :estimated_diameter=>{:kilometers=>{:estimated_diameter_min=>0.008405334, :estimated_diameter_max=>0.0187948982},
                :meters=>{:estimated_diameter_min=>8.4053340207, :estimated_diameter_max=>18.7948982439}, :miles=>{:estimated_diameter_min=>0.0052228308,
                :estimated_diameter_max=>0.0116786047}, :feet=>{:estimated_diameter_min=>27.5765560686, :estimated_diameter_max=>61.6630539546}},
                :is_potentially_hazardous_asteroid=>false, :close_approach_data=>[{:close_approach_date=>"2019-03-30", :close_approach_date_full=>"2019-Mar-30 07:28",
                :epoch_date_close_approach=>1553930880000, :relative_velocity=>{:kilometers_per_second=>"7.8106160396", :kilometers_per_hour=>"28118.2177426427",
                :miles_per_hour=>"17471.5670190326"}, :miss_distance=>{:astronomical=>"0.0098105541", :lunar=>"3.8163055449", :kilometers=>"1467637.996879767",
                :miles=>"911947.9636721046"}, :orbiting_body=>"Earth"}], :is_sentry_object=>false}
    assert_equal expected, neos.parsed_asteroids_data[0]
  end

  def test_it_returns_largest_astroid_in_feet
    neos = NearEarthObjects.new('2019-03-30')

    assert_equal '10233 feet', neos.largest_astroid_diameter_feet
  end

  # def test_a_date_returns_a_list_of_neos
  #   results = NearEarthObjects.find_neos_by_date('2019-03-30')
  #   require "pry"; binding.pry
  #   assert_equal '(2019 GD4)', results[:astroid_list][0][:name]
  # end
end
