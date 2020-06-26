require 'faraday'
require 'figaro'
require 'pry'
# Load ENV vars via Figaro
Figaro.application = Figaro::Application.new(environment: 'production', path: File.expand_path('../config/application.yml', __FILE__))
Figaro.load

class FormatData
  attr_reader :astroid_list, :column_labels

  def initialize(astroid_list)
    @astroid_list = astroid_list
    @column_labels = {name: "Name", diameter: "Diameter", miss_distance: "Missed The Earth By:"}
  end

  def column_data
    column_labels.each_with_object({}) do |(col, label), hash|
      hash[col] = {
        label: label,
        width: [astroid_list.map { |astroid| astroid[col].size }.max, label.size].max}
      end
  end

  def header
    "| #{ column_data.map { |_,col| col[:label].ljust(col[:width]) }.join(' | ') } |"
  end

  def divider
    "+-#{column_data.map { |_,col| "-"*col[:width] }.join('-+-') }-+"
  end

  def format_row_data(row_data, column_data)
    row = row_data.keys.map { |key| row_data[key].ljust(column_data[key][:width]) }.join(' | ')
    puts "| #{row} |"
  end

  def create_rows
    astroid_list.each { |astroid| format_row_data(astroid, column_data) }
  end

end
