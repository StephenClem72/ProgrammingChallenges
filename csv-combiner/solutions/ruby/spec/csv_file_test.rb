require 'test/unit'
require_relative '../csv_file'

class CsvFileTest < Test::Unit::TestCase
  
  def subject
    @subject ||= CsvFile.new(csv_file)
  end

  def csv_file
    './spec/fixtures/test_1.csv'
  end

  def test_new
    assert_equal(subject.file_name, csv_file)
  end

  def test_read
    call = subject.read
    assert_equal(call.class, File)
  end

  def test_basename
    call = subject.basename
    assert_equal(call, csv_file.split('/').last)
  end

  def test_csv_name
    csv_no_ex = './spec/fixtures/test_1'
    assert_equal(subject.send(:csv_name, csv_file), csv_file)
    assert_equal(subject.send(:csv_name, csv_no_ex), csv_file)
  end
end