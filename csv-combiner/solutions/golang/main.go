package main

import (
  "os"
  "./csvFile"
  "fmt"
)

func main() {
  args := os.Args[1:]
  if len(args) == 0 {
    fmt.Println("Please provide some CSV files to combine!")
  } else {
    csvFile.Blend(args)
  }
}
