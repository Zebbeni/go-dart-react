# go-dart-react
Boilerplate Go App with Dart + React Frontend

## Requirements
- [Create new GAE project](https://console.cloud.google.com/projectselector/appengine)
- [Google Appengine SDK for Go](https://cloud.google.com/appengine/docs/standard/go/download)
- [Dart](https://webdev.dartlang.org/guides/get-started)

## Build & Run

### 1. Compile Dart to Javascript
    pub get
    pub build
    
### 2. Run Local
    goapp serve
OR run front-end only for debugging:
    pub serve web
- Both serve on localhost:8080

### 3. Deploy
    goapp deploy -application [APPLICATION_ID] -version [VERSION_ID] .
- Note: If 403 error, try deleting ~/.appcfg_oauth2_tokens so it re-authenticates
