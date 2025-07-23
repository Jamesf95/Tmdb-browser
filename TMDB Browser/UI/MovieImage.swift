//
//  MovieImage.swift
//  TMDB Browser
//
//  Created by James Foot on 22/07/2025.
//

import SwiftUI

private let placeholderImage = URL(string: "https://placehold.co/500x750")!

struct MovieImage: View {
    
    let path: String?
    let aspectRatio: Double
    
    init(path: String?, aspectRatio: Double = 2/3) {
        self.path = path
        self.aspectRatio = aspectRatio
    }
    
    
    var imageUrl: URL {
        guard let path else { return placeholderImage }
        
        var components = URLComponents(string: "https://image.tmdb.org")
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        components?.path = "/t/p/w500/" + path + ".jpg"
        let url = components?.url ?? placeholderImage
        return url
    }
    
    var body: some View {
        AsyncImage(
            url: imageUrl,
            content: { image in
                image
                    .resizable()
                    .aspectRatio(aspectRatio, contentMode: .fit)
            },
            placeholder: {
                ZStack {
                    // Empty image to be the background so that it's the same size as the
                    // proper image above, preventing awkward resizing behavior.
                    Image("")
                        .resizable()
                        .aspectRatio(aspectRatio, contentMode: .fit)
                        .padding()
                        .background(.gray.opacity(0.5))
                    
                    Image(systemName: "square.and.arrow.up.fill")
                }
            }
        )
    }
    
}

#Preview {
    MovieImage(path: "/etT14XfDEqhQZdD47ywpyihXPyW.jpg", aspectRatio: 2/3)
}
