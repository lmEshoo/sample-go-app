package main

import (
    "fmt"
    "os"
    "net/http"
)

func reverse(s string) string {
	reverseString := []rune(s)
	for i, j := 0, len(reverseString)-1; i < len(reverseString)/2; i, j = i+1, j-1 {
		reverseString[i], reverseString[j] = reverseString[j], reverseString[i]
	}
	return string(reverseString)
}

func indexHandler( w http.ResponseWriter, r *http.Request){
  fmt.Fprintf(w, reverse(os.Getenv("ECHO")))
}

func main(){
  http.HandleFunc("/", indexHandler)
  http.ListenAndServe(":5200",nil)
}
