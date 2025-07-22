//
//  MovieDetailPage.swift
//  TMDB Browser
//
//  Created by James Foot on 22/07/2025.
//

import SwiftUI

struct MovieDetailPage: View {
    
    let movie: Movie
    
    var body: some View {
        VStack {
            MovieImage(path: movie.posterPath)
            
            Text(movie.title)
        }
        .navigationTitle(movie.title)
    }
    
}
