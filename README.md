# TMDB Browser

This is a small SwiftUI app that communicates with the TMDB API and displays a list of movies. 

## API Key

This project requires an API key. One can be created on [the TMDB website](https://developer.themoviedb.org/docs/getting-started). 

To compile, the API key will need to be added in Swift. The file `API/ApiKey.swift` is being ignored by git so that the API key isn't committed to the repository. To compile, you'll need to add your own key like this:

```swift 
// ApiKey.swift
let apiKey = "<YOUR ACTUAL API KEY>"
```

