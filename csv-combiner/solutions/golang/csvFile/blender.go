package csvFile

import(
  "fmt"
  "path/filepath"
)

// takes array for csvs as argument and merged them into one
func Blend(csvs []string) {
  fmt.Println("Merging your CSVs...")
  
  // assigns empty array for new csv
  var newCsv [][]string

  // add row for headers
  newCsv = append(newCsv, CsvHeaders())
  
  // loops through each CSV andnd appends 
  for i := 0; i < len(csvs); i++ {
    newCsv = append(newCsv, CsvRow(csvs[i])...)
  }
  Write(newCsv)
}

// accepts string of file name
func CsvRow(fileName string) [][]string {
  // reads csv file_name
  rows := Read(fileName)

  // loops through each row in csv and writes to new csv
  for i := 0; i < len(rows); i++ {

    // grab file basename for additional column
    fileBasename := filepath.Base(fileName)

    // append filename csv row array
    rows[i] = append(rows[i], fileBasename)
  }
  return rows
}

// default headers that will always be used for new csv
func CsvHeaders() []string {
  return []string{"email_hash", "category", "filename"}
}
