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
    RandSmall int   `json:"randSmall"`
    RandBig   int   `json:"randBig"`
}

func funcHandler(w http.ResponseWriter, r *http.Request) {
    randSmall := rand.Intn(10)
    randBig := rand.Intn(10)
    response := &Response{
        RandSmall: randSmall,
        RandBig: randBig,
    }
    responseJson, _ := json.Marshal(response)
    fmt.Fprintln(w, string(responseJson))
}

