package csvFile

import (
  "os"
  "encoding/csv"
  errHandler "../errorHandling"
)

// takes an array of a csv path as an argument and returns nested array of all rows in csv
func Read(csvpath string) ([][]string) {
  file, err := os.Open(csvpath)
  errHandler.Check("Cannot read file::", err)

  // read csv file
  reader := csv.NewReader(file)

  //set to true to account for escape quotes 
  reader.LazyQuotes = true
  records, _ := reader.ReadAll()
  
  // returns empty array if csv is empty
  if len(records) == 0{
    return records
  }

  // return all records 
  return records[1:]
}
