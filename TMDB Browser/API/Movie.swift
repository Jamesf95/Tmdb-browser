//
//  PageResponse.swift
//  TMDB Browser
//
//  Created by James Foot on 22/07/2025.
//

// A generic wrapper around the page in the JSON response.
struct Page<T: Codable>: Codable {
    let page: Int
    let results: [T]
}

// This matches the pure JSON of the response. In this simple example
// I haven't mapped to a domain object (because I haven't needed to).
// There's a `genre_id` property available and if I was using that
// I'd want to map that to a Genere struct rather than pass around the ids.
struct Movie: Codable, Identifiable, Hashable {
    let id: Int
    let posterPath: String?
    let title: String
    let overview: String
    let backdropPath: String?
    let voteAverage: Double?
}
