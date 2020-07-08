require 'test/unit'
require_relative '../csv_blender'
require 'pry'

class CsvBlenderTest < Test::Unit::TestCase
  
  def subject
    @subject ||= CsvBlender.new(csv_list, test_csv)
  end

  def test_csv
    './spec/fixtures/test_combiner.csv'
  end

  def csv_list
    ['./spec/fixtures/test_1.csv', './spec/fixtures/test_2.csv']
  end

  def clear_csv
    subject.new_csv.clear
  end

  def read_csv(csv)
    File.readlines(csv)[1..-1]
  end

  def csv_basename(csv)
    File.basename(csv)
  end

  # tests
  def test_new
    assert_equal(subject.csv_list, csv_list)
    assert_equal(subject.new_csv.class, CsvFile)
  end

  def test_blend
    subject.blend
    csv_list.each do |csv|
      assert_block do
        read_csv(csv).all? do |row| 
          read_csv(test_csv).any? do |combined_row|
            combined_row.include?(row.strip)
          end
        end
      end
    end
    # clear CSV after test so that it can be populated upon next suite run
    clear_csv
  end

  def test_content_row
    content = "firstname,last_name\n"
    csv_name = csv_basename(test_csv)
    expected_row = "firstname,last_name,#{csv_name}\n"
    call = subject.send(:content_row, content, csv_name)
    assert_equal(call, expected_row)
  end
end