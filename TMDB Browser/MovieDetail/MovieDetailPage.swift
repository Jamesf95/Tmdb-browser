//
//  MovieDetailPage.swift
//  TMDB Browser
//
//  Created by James Foot on 22/07/2025.
//

import SwiftUI

private let posterWidth: CGFloat = 150
private let posterHeight: CGFloat = posterWidth * 3 / 2
private let posterOffset: CGFloat = posterHeight / 2

struct MovieDetailPage: View {
    
    let movie: Movie
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ZStack(alignment: .leading) {
                    MovieImage(path: movie.backdropPath, aspectRatio: 1.5)
                        .frame(maxWidth: .infinity)
                    
                    MovieImage(path: movie.posterPath)
                        .frame(width: posterWidth, height: posterHeight)
                        .cornerRadius(20)
                        .shadow(radius: 20)
                        .offset(CGSize(width: 0, height: posterOffset))
                        .padding()
                    
                }
                
                HStack {
                    Spacer()
                    
                    if let voteAverage = movie.voteAverage {
                        StarRatingView(voteAverage: voteAverage)
                    }
                    
                    Spacer()
                }
                .padding(.leading, posterWidth)
                // Make sure the title doesn't get too close
                // to the poster, but with some padding to offset
                .frame(minHeight: posterOffset - 20)
                
                Text(movie.title)
                    .font(.title)
                    .padding(.horizontal)
                                
                Text(movie.overview)
                    .font(.body)
                    .padding(.horizontal)
                
            }
        }
        .ignoresSafeArea(.container, edges: .top)
    }
    
}

#Preview {
    MovieDetailPage(
        movie: Movie(
            id: 0,
            posterPath: "/41dfWUWtg1kUZcJYe6Zk6ewxzMu.jpg",
            title: "How to train your dragon",
            overview: "Lorem ipsum",
            backdropPath: "/etT14XfDEqhQZdD47ywpyihXPyW.jpg",
            voteAverage: 1.2
        )
    )
}
