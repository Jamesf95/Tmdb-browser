//
//  MovieGridItem.swift
//  TMDB Browser
//
//  Created by James Foot on 22/07/2025.
//

import SwiftUI

struct MovieGridItem: View {
    let movie: Movie
    let onTap: (Movie) -> Void
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            MovieImage(path: movie.posterPath)
        
            Text(movie.title)
                .frame(maxWidth: .infinity)
                .padding()
                .font(.headline)
                .background(.thinMaterial)
        }
        .cornerRadius(20)
        .onTapGesture {
            onTap(movie)
        }
    }

}

#Preview {
    let movie = Movie(
        id: 1,
        posterPath: "/ombsmhYUqR4qqOLOxAyr5V8hbyv",
        title: "Test",
        overview: "",
        backdropPath: "",
        voteAverage: 1.2
    )
    MovieGridItem(movie: movie) { _ in }
}
