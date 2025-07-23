//
//  ApiClient.swift
//  TMDB Browser
//
//  Created by James Foot on 23/07/2025.
//

import Foundation

// An enum case of different errors. I'm using typed
// throws mainly to try it out as I haven't used them properly yet.
enum ApiClientError: Error {
    case invalidUrl
    case ioError
    case jsonError
}

// The class for making API calls. I'd be tempted to
// make this a protocol to make testing and mocking easier.
class ApiClient {
        
    private let baseUrl: String
    private let jsonDecoder: JSONDecoder
    
    init(baseUrl: String, jsonDecoder: JSONDecoder) {
        self.baseUrl = baseUrl
        self.jsonDecoder = jsonDecoder
    }
    
    func get<T: Decodable>(path: String, queryItems: [String : String] = [:]) async throws(ApiClientError) -> T {
        guard let url = buildUrl(path: path, queryItems: queryItems) else {
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
    
    private func fetchData(request: URLRequest) async throws(ApiClientError) -> Data {
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return data
            
        } catch {
            print("Network error: \(error)")
            throw .ioError
        }
    }
 
    private func decodeJson<T: Decodable>(data: Data) throws(ApiClientError) -> T {
        do {
            return try jsonDecoder.decode(T.self, from: data)
            
        } catch {
            print("JSON Decoding error: \(error)")
            throw .jsonError
        }
    }
    
    private func buildUrl(path: String, queryItems: [String : String] = [:]) -> URL? {
        guard var components = URLComponents(string: baseUrl) else {
            return nil
        }
        components.path = path
        components.queryItems = queryItems.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        return components.url
    }
    
}
