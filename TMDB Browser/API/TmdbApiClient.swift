//
//  TmdbApiClient.swift
//  TMDB Browser
//
//  Created by James Foot on 22/07/2025.
//

import Foundation

enum TmdbApiClientError: Error {
    case invalidUrl
    case ioError
    case jsonError
}

class TmdbApiClient {
        
    private static let baseUrl = "https://api.themoviedb.org"
    
    private lazy var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func search(query: String) async throws(TmdbApiClientError) -> TmdbApiResponse {
        return try await makeGetRequest(to: "/search/movie", queryItems: ["query" : query])
    }
    
    func fetchDiscoverList() async throws(TmdbApiClientError) -> TmdbApiResponse {
        return try await makeGetRequest(to: "/discover/movie")
    }
    
    private func makeGetRequest(
        to path: String,
        queryItems: [String : String] = [:]
    ) async throws(TmdbApiClientError) -> TmdbApiResponse {
        guard let url = Self.buildUrl(path: path, queryItems: queryItems) else {
            throw .invalidUrl
        }
        
        print("<-- \(url.absoluteString)")
        
        let request = URLRequest(url: url)
        let data = try await fetchData(request: request)
        
        let dataString = String(data: data, encoding: .utf8)
        print(dataString ?? "nil")
        print("<--")
        
        return try decodeJson(data: data)
    }
    
    private func fetchData(request: URLRequest) async throws(TmdbApiClientError) -> Data {
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return data
            
        } catch {
            print("Network error: \(error)")
            throw .ioError
        }
    }
 
    private func decodeJson(data: Data) throws(TmdbApiClientError) -> TmdbApiResponse {
        do {
            return try jsonDecoder.decode(PageWrapper<Movie>.self, from: data)
            
        } catch {
            print("JSON Decoding error: \(error)")
            throw .jsonError
        }
    }
    
    static func buildUrl(path: String, queryItems: [String : String] = [:]) -> URL? {
        guard var components = URLComponents(string: Self.baseUrl) else {
            return nil
        }
        components.path = "/3" + path
        
        var queryItems = queryItems.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        // api_key needed for every request.
        queryItems.append (URLQueryItem(name: "api_key", value: apiKey))
        
        components.queryItems = queryItems
        return components.url
    }
    
}
