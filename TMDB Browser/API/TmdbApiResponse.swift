//
//  PageResponse.swift
//  TMDB Browser
//
//  Created by James Foot on 22/07/2025.
//

typealias TmdbApiResponse = PageWrapper<Movie>

struct PageWrapper<T: Codable>: Codable {
    let page: Int
    let results: [T]
}

struct Movie: Codable {
    let id: Int
    let posterPath: String
    let title: String
}
