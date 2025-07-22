//
//  ContentView.swift
//  TMDB Browser
//
//  Created by James Foot on 22/07/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }.onTapGesture {
            Task {
                do {
                    let result = try await TmdbApiClient().fetchDiscoverList()
                    print(result)
                } catch {
                    print(error)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
