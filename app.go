package app

import (
    "fmt"
    "net/http"
)

func init() {
    fs := http.FileServer(http.Dir("build/web"))
    http.Handle("/", fs)
    http.HandleFunc("/somefunc", handler)
}

func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprint(w, "Hello there.")
}
