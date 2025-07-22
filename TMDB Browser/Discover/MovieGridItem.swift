//
//  MovieGridItem.swift
//  TMDB Browser
//
//  Created by James Foot on 22/07/2025.
//

import SwiftUI

struct MovieGridItem: View {
    let movie: Movie
    
    var body: some View {
        VStack {
            if let posterImageUrl {
                AsyncImage(
                    url: posterImageUrl,
                    content: { image in
                        image.resizable()
                            .aspectRatio(2/3, contentMode: .fit)
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
            }
            
            Text(movie.title)
                .font(.headline)
                .frame(height: 50)
        }
    }
    
    private var posterImageUrl: URL? {
        var components = URLComponents(string: "https://image.tmdb.org")
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        let path = "/t/p/w500/" + movie.posterPath + ".jpg"
        components?.path = path
        return components?.url
    }
}

#Preview {
    let movie = Movie(
        id: 1,
        posterPath: "/ombsmhYUqR4qqOLOxAyr5V8hbyv",
        title: "Test"
    )
    MovieGridItem(movie: movie)
}
