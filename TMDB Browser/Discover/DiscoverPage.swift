//
//  DiscoverPage.swift
//  TMDB Browser
//
//  Created by James Foot on 22/07/2025.
//

import SwiftUI

struct DiscoverPage: View {
    
    @State private var viewModel = DiscoverViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let onMovieClicked: (Movie) -> Void
    
    var body: some View {
        ZStack {
            movieGrid
            
            if viewModel.isLoading {
                loadingView
            }
            
            if viewModel.error != nil {
                somethingWentWrongView
            }
        }
        .onAppear { viewModel.onAppear() }
        .navigationTitle("Discover")
    }
    
    var movieGrid: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.movies, id: \.self) { movie in
                    MovieGridItem(movie: movie, onTap: onMovieClicked)
                }
            }
        }
        .padding()
    }
    
    var loadingView: some View {
        ProgressView("Loading")
    }
    
    var somethingWentWrongView: some View {
        VStack {
            Text("Something went wrong")
                .font(.title)
                .padding(.bottom, 4)
            
            Text("Please check your network and try again")
                .font(.body)
                .padding(.bottom, 8)
            
            Button("Retry") {
                viewModel.onRetry()
            }
        }
        .padding()
    }
    
}

#Preview {
    DiscoverPage() { s_ in }
}
