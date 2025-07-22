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
    
    func fetchDiscoverList() async throws(TmdbApiClientError) -> TmdbApiResponse {
        guard let url = Self.buildUrl(path: "/discover/movie") else {
            throw .invalidUrl
        }
        
        print("<-- \(url.absoluteString)")
        
        let request = URLRequest(url: url)
        let data = try await fetchData(request: request)
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
            let jsonResponse = String(data: data, encoding: .utf8)
            print(jsonResponse)
            
            return try jsonDecoder.decode(PageWrapper<Movie>.self, from: data)
            
        } catch {
            print("JSON Decoding error: \(error)")
            throw .jsonError
        }
    }
    
    static func buildUrl(path: String) -> URL? {
        guard var components = URLComponents(string: Self.baseUrl) else {
            return nil
        }
        components.path = "/3" + path
        components.queryItems = [
            // api_key needed for every request.
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        return components.url
    }
    
}
