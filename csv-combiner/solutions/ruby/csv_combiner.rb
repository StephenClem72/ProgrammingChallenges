require_relative('csv_blender')
require 'pry'

class CsvCombiner
  class << self
    # fires off the prompt to combine csv
    def prompt(csv_list)
      return nil if csvs_empty?(csv_list)
      csv_name = get_new_csv_name
      combine_csvs(csv_list, csv_name)
    end

    private

    # asks user if they would like a different file name
    def get_new_csv_name
      puts 'What is the name of your combined CSV? (press enter to use default name)'
      filename = STDIN.gets.chomp
      filename.empty? ? nil : filename
    end

    # calls CsvBlender to combine csvs from list of arguments
    def combine_csvs(csv_list, new_csv_name)
      puts 'Creating CSV...'
      blender = CsvBlender.new(csv_list, new_csv_name)
      blender.blend
      puts "Done! You can find you new CSV here: #{blender.new_csv.full_path}"
    end

    # returns a falsey value if csv count is 0 
    def csvs_empty?(csv_list)
      if csv_list.empty?
        puts('Please provide some CSV files to combine!')
        true
      else
        false
      end
    end
  end
end