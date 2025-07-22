//
//  MovieImage.swift
//  TMDB Browser
//
//  Created by James Foot on 22/07/2025.
//

import SwiftUI

private let placeholderImage = URL(string: "https://placehold.co/500x750")!

struct MovieImage: View {
    
    let path: String
    
    var imageUrl: URL {
        var components = URLComponents(string: "https://image.tmdb.org")
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        let path = "/t/p/w500/" + path + ".jpg"
        components?.path = path
        return components?.url ?? placeholderImage
    }
    
    var body: some View {
        AsyncImage(
            url: imageUrl,
            content: { image in
                image.resizable()
                    .aspectRatio(2/3, contentMode: .fit)
            },
            placeholder: {
                ProgressView()
            }
        )
    }
    
}
