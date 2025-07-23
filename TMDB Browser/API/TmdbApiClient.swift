//
//  TmdbApiClient.swift
//  TMDB Browser
//
//  Created by James Foot on 22/07/2025.
//

import Foundation

// An api client that's specific to the tmdb api.
class TmdbApiClient {
        
    private static let baseUrl = "https://api.themoviedb.org"
    
    private lazy var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private lazy var apiClient: ApiClient = {
        ApiClient(baseUrl: Self.baseUrl, jsonDecoder: self.jsonDecoder)
    }()
    
    func search(query: String) async throws(ApiClientError) -> Page<Movie> {
        return try await makeGetRequest(to: "/3/search/movie", queryItems: ["query" : query])
    }
    
    func fetchDiscoverList() async throws(ApiClientError) -> Page<Movie> {
        return try await makeGetRequest(to: "/3/discover/movie")
    }
    
    private func makeGetRequest(
        to path: String,
        queryItems: [String : String] = [:]
    ) async throws(ApiClientError) -> Page<Movie> {
        
        // Add the api key to the query items
        var allQueryItems = queryItems
        allQueryItems["api_key"] = apiKey
        
        return try await apiClient.get(path: path, queryItems: allQueryItems)
        
    }
}
