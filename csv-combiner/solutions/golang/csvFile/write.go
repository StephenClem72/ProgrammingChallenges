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
  combinedFileName := newFileName()

  file, err := os.Create(combinedFileName)
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
  abs, err := filepath.Abs(combinedFileName)
  error.Check("Unable to parse Absolute path::", err)

  fmt.Println("Done! You can view your CSV here: ", abs)
}

// this will always write to a file in your current directory with the file name of your input
func newFileName() string {
  fmt.Println("What is the name of your combined CSV? (press enter to use default name)")
  var csvName string
  fmt.Scan(&csvName)
  if len(csvName) > 0 {
    csvName = "golang_combiner.csv"
  }
  return csvName
}
