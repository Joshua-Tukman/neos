require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative 'near_earth_objects'
require_relative 'format_data'

class FormatDataTest < Minitest::Test

  def test_it_exists
    neos = NearEarthObjects.new('2019-03-30')
    format = FormatData.new(neos.formatted_astroid_data)

    assert_instance_of FormatData, format
  end

  def test_it_can_return_column_data
    neos = NearEarthObjects.new('2019-03-30')
    format = FormatData.new(neos.formatted_astroid_data)

    expected = {:name=>{:label=>"Name", :width=>17},
                :diameter=>{:label=>"Diameter",
                :width=>8},
                :miss_distance=>{:label=>"Missed The Earth By:", :width=>20}}
    assert_equal expected, format.column_data
  end

  def test_it_can_make_a_header
    neos = NearEarthObjects.new('2019-03-30')
    format = FormatData.new(neos.formatted_astroid_data)

    expected = "| Name              | Diameter | Missed The Earth By: |"
    assert_equal expected, format.header
  end

  def test_it_can_make_a_divider
    neos = NearEarthObjects.new('2019-03-30')
    format = FormatData.new(neos.formatted_astroid_data)

    expected = "+-------------------+----------+----------------------+"
    assert_equal expected, format.divider
  end

  # def test_it_can_format_row_data
  #   neos = NearEarthObjects.new('2019-03-30')
  #   format = FormatData.new(neos.formatted_astroid_data)
  #
  #   expected = "| (2019 GD4)        | 61 ft    | 911947 miles         |"
  #   assert_equal expected, format.format_row_data(format.astroid_list[0], format.column_data)
  # end

  def test_it_can_create_rows
    neos = NearEarthObjects.new('2019-03-30')
    format = FormatData.new(neos.formatted_astroid_data)

    expected = [{:name=>"(2019 GD4)", :diameter=>"61 ft", :miss_distance=>"911947 miles"},
                {:name=>"(2019 GN1)", :diameter=>"147 ft", :miss_distance=>"9626470 miles"},
                {:name=>"(2019 GN3)", :diameter=>"537 ft", :miss_distance=>"35277204 miles"},
                {:name=>"(2019 GB)", :diameter=>"81 ft", :miss_distance=>"553908 miles"},
                {:name=>"(2019 FQ2)", :diameter=>"70 ft", :miss_distance=>"2788140 miles"},
                {:name=>"(2011 GE3)", :diameter=>"123 ft", :miss_distance=>"35542652 miles"},
                {:name=>"(2019 FT)", :diameter=>"512 ft", :miss_distance=>"5503325 miles"},
                {:name=>"(2019 FS1)", :diameter=>"134 ft", :miss_distance=>"6241521 miles"},
                {:name=>"141484 (2002 DB4)", :diameter=>"10233 ft", :miss_distance=>"37046029 miles"},
                {:name=>"(2011 GK44)", :diameter=>"147 ft", :miss_distance=>"10701438 miles"},
                {:name=>"(2012 QH8)", :diameter=>"1071 ft", :miss_distance=>"37428269 miles"},
                {:name=>"(2019 UZ)", :diameter=>"51 ft", :miss_distance=>"37755577 miles"}]
    assert_equal expected, format.create_rows
  end

end
