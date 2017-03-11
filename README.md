# go-dart-react
Boilerplate Go App with Dart + React Frontend

## Requirements
- [Google Appengine SDK for Go](https://cloud.google.com/appengine/docs/standard/go/download)

## Run locally
    goapp serve
- Serves on localhost:8080

## Deploy to GAE
    goapp deploy -application [APPLICATION_ID] -version [VERSION_ID] .
- Note: If 403 error, may need to delete ~/.appcfg_oauth2_tokens and try again
