//
//  ContentView.swift
//  TMDB Browser
//
//  Created by James Foot on 22/07/2025.
//

import SwiftUI

struct ContentView: View {
    @State var selectedMovie: Movie?
    
    var body: some View {
        NavigationStack {
            DiscoverPage() { movie in
                selectedMovie = movie
            }
            .navigationDestination(item: $selectedMovie) { movie in
                MovieDetailPage(movie: movie)
            }
        }
    }
}

#Preview {
    ContentView()
}
