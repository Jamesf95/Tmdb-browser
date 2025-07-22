//
//  DiscoverViewModel.swift
//  TMDB Browser
//
//  Created by James Foot on 22/07/2025.
//

import SwiftUI

@Observable
class DiscoverViewModel {
    
    var isLoading: Bool = false
    var movies: [Movie] = []
    var error: Error?
    
    private let apiClient = TmdbApiClient()

    func onAppear() {
        Task {
            await loadDiscoverList()
        }
    }
    
    func onRetry() {
        Task {
            await loadDiscoverList()
        }
    }
    
    private func loadDiscoverList() async {
        self.isLoading = true
        defer {
            self.isLoading = false
        }
        
        do {
            let response = try await apiClient.fetchDiscoverList()
            self.movies = response.results
            
        } catch {
            self.error = error
        }
    }
    
}
