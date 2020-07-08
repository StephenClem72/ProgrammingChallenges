package csvFile

import (
  "os"
  "encoding/csv"
  "fmt"
  "path/filepath"
  error "../errorHandling"
)

// takes an nested array of strings and writes each row to a new csv file
// example [[firstname, lastname],[jon, doe],[tom, cruise]]
func Write(csvdata [][]string) {
  // create new file
  file, err := os.Create(newFileName())
  error.Check("Cannot create file::", err)
  defer file.Close()
  
  // wrap file in a csv writer to prepare for inserting rows
  writer := csv.NewWriter(file)
  defer writer.Flush()
  
  // loop through each array and insert as row in csv
  for _, value := range csvdata {
    err := writer.Write(value)
    error.Check("Cannot write to file::", err)
  }

  // get absolute path of file for 'Done!' message.
  abs, err := filepath.Abs(newFileName())
  error.Check("Unable to parse Absolute path::", err)

  fmt.Println("Done! You can view your CSV here: ", abs)
}

// this will always write to a file in your current directory with this name
func newFileName() string {
  return "golang_combiner.csv"
}
