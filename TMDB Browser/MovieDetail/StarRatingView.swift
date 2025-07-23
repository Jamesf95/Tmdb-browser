//
//  StarRatingView.swift
//  TMDB Browser
//
//  Created by James Foot on 23/07/2025.
//

import SwiftUI

private let starSize: CGFloat = 24

struct StarRatingView: View {
    let voteAverage: Double
    
    // Vote average is a float between 0 - 10, so it needs to be
    // converted to an Int between 0 and 5.
    private var starCount: Int {
        return Int(voteAverage) / 2
    }
    
    var body: some View {
        HStack {
            ForEach(0..<5) { i in
                let iconName = i < self.starCount ? "star.fill" : "star"
                let color: Color = i < self.starCount ? .yellow : .gray
                
                Image(systemName: iconName)
                    .resizable()
                    .frame(width: starSize, height: starSize)
                    .foregroundStyle(color)
            }
        }
    }
}

#Preview {
    VStack {
        StarRatingView(voteAverage: 0)
        StarRatingView(voteAverage: 5.2)
    }
}
