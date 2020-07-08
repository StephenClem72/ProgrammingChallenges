# Facade for File class to help with basic functionalities of reading and writing to csvs

class CsvFile

  attr_reader :file_name

  def initialize(file_name)
    @file_name = csv_name(file_name)
  end

  # reads file
  def read
    open_file('r')
  end

  # eliminated all contents of a file
  def clear
    open_file('w')
  end

  # takes one string of content and appends it to the file on a new line
  def write_row(content)
    File.write(file_name, content, mode: 'a')
  end

  # opens file
  def open_file(method)
    File.open(file_name, method)
  end

  # gets base name of file for additional column source column
  def basename
    File.basename(file_name) 
  end

  # gets absolute path for easy retrieval
  def full_path
    File.expand_path(file_name)
  end

  private

  # appends csv file extention if not included in file name
  def csv_name(file_name)
    # regex returns nil if csv extention is not found, integer if extension is found 
    return file_name if file_name =~ /.\.csv$/i
    # adds extentions if csv extension is not found
    "#{file_name}.csv"
  end
end