//
//  DiscoverViewModel.swift
//  TMDB Browser
//
//  Created by James Foot on 22/07/2025.
//

import SwiftUI
import Combine

@Observable
class DiscoverViewModel {
    
    var isLoading: Bool = false
    var movies: [Movie] = []
    var error: Error?
        
    var searchText: String = "" {
        didSet {
            searchRequestSubject.send(searchText)
        }
    }
    
    private let searchRequestSubject = PassthroughSubject<String, Never>()
    private let apiClient = TmdbApiClient()
    private var searchTextCancellable: Cancellable?
    
    func onAppear() {
        searchTextCancellable = subscribeToSearchText()
        refreshMovieList()
    }
    
    func onDisappear() {
        searchTextCancellable?.cancel()
    }
    
    func onRetry() {
        refreshMovieList()
    }
    
    private func subscribeToSearchText() -> Cancellable {
        return searchRequestSubject
            .eraseToAnyPublisher()
            .removeDuplicates()
            // Set the loading state before the debounce so the UI updates immediately.
            .handleEvents(receiveOutput: { _ in
                self.isLoading = true
                self.movies = []
                self.error = nil
            })
            // Debounce to allow the user to finish typing before we hit the API.
            .debounce(for: 1, scheduler: RunLoop.main)
            .sink { _ in
                self.refreshMovieList()
            }

    }
        
    private func refreshMovieList() {
        Task {
            await refreshMoveListAsync()
        }
    }
    
    // The aysnc function that hits the API and updates the state
    // automatically.
    private func refreshMoveListAsync() async {
        self.isLoading = true
        
        // Defer is nice here because I can't forget to
        // set isLoading back to false
        defer {
            self.isLoading = false
        }
        
        do {
            let searchParam = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
            let response = searchParam.isEmpty
                ? try await apiClient.fetchDiscoverList()
                : try await apiClient.search(query: searchParam)
  
            self.movies = response.results
        } catch {
            self.error = error
        }
    }
    
}
