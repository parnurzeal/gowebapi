package main

import (
  "fmt"
  "database/sql"
  _ "github.com/go-sql-driver/mysql"
  "net/http"
)

func handler(w http.ResponseWriter, r *http.Request){
  fmt.Fprintf(w, "Hi there, %s", r.URL.Path[1:])

}

func main(){
  db, err:= sql.Open("mysql","root:password@tcp(127.0.0.1:3306)/inventory")
  if err != nil {
    panic(err.Error()) // Just for example purpose. You should use proper error handling instead of panic
  }
  defer db.Close()

  err = db.Ping()
  if err != nil {
    panic(err.Error()) // proper error handling instead of panic in your app
  }
  fmt.Println("Hello")
  http.HandleFunc("/", handler)
  http.ListenAndServe(":9999", nil)
}
