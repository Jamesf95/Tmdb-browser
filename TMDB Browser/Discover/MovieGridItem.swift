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
            Text(movie.title)
                .font(.headline)
        }
    }
}
