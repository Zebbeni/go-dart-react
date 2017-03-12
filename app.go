package app

import (
    "fmt"
    "net/http"
    "math/rand"
    "encoding/json"
)

func init() {
    fs := http.FileServer(http.Dir("build/web"))
    http.Handle("/", fs)
    http.HandleFunc("/func", funcHandler)
}

type Response struct {
    RandLeft  int   `json:"randLeft"`
    RandRight int   `json:"randRight"`
}

func funcHandler(w http.ResponseWriter, r *http.Request) {
    randLeft := rand.Intn(10)
    randRight := rand.Intn(10) + 10
    response := &Response{
        RandLeft:  randLeft,
        RandRight: randRight,
    }
    responseJson, _ := json.Marshal(response)
    fmt.Fprintln(w, string(responseJson))
}

