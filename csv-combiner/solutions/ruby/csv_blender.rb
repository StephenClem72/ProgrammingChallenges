require_relative('csv_file')

class CsvBlender

  attr_reader :csv_list
  attr_accessor :new_csv

  # default name in the case no name is enters
  DEFAULT_NAME = "ruby_combiner"

  # default headers for expected csv
  HEADERS = "email_hash,category,filename\n"

  def initialize(csv_list, new_csv_name)
    @csv_list = csv_list

    # instantiate new csv file
    @new_csv = CsvFile.new(new_csv_name || DEFAULT_NAME)
  end


  def blend
    # clear contents of file if already written to; Make way for more content
    new_csv.clear

    # write the headers in the first line of the csv
    new_csv.write_row(HEADERS)

    # loop through existing csvs and call other objects to help push new new csv
    csv_list.each do |csv_name|
      csv = CsvFile.new(csv_name)
      push_to_new_csv(csv)
    end
  end

  private

  # writes to csv
  def push_to_new_csv(csv)
    new_csv.write_row(csv_entries(csv))
  end

  # loops through each line in the csv and modify with source column
  def csv_entries(csv)
    csv.read.map do |row|
      content = content_row(row, csv.basename)
    end[1..-1].to_a.join
  end

  # formats the content row, appending the file name
  def content_row(content, file_name)
    content.strip
           .split(",")
           .push(file_name)
           .join(",")
           .concat("\n")
  end
end