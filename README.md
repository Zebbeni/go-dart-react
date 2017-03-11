# go-dart-react
Boilerplate Go App with Dart + React Frontend

## Requirements
- [Create new GAE project](https://console.cloud.google.com/projectselector/appengine)
- [Google Appengine SDK for Go](https://cloud.google.com/appengine/docs/standard/go/download)
- [Dart](https://webdev.dartlang.org/guides/get-started)

## Compile Dart to Javascript
    pub get
    pub build
    
## Run locally
    goapp serve
- Serves on localhost:8080

## Deploy to Google App Engine
    goapp deploy -application [APPLICATION_ID] -version [VERSION_ID] .
- Note: If 403 error, try deleting ~/.appcfg_oauth2_tokens to 
