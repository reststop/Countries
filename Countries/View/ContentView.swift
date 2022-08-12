//
//  ContentView.swift
//  Countries
//
//  Created by carl on 8/11/22.
//

import SwiftUI

struct ContentView: View {
    let loader = Loader()
    @State private var searchText = ""

    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(searchResults) { country in
                            CountryView(country: country)
                    }
                }
                .searchable(text: $searchText)
                .navigationTitle("Country")
            }
            .navigationViewStyle(.stack)
        }
        //.frame( maxWidth: .infinity, maxHeight: .infinity)
    }

    var searchResults: [Country] {
        if searchText.isEmpty {
            return loader.countryList
        } else {
            // note .lowercased() added to make
            // searches case independent
            // Remove if we want case dependent searches
            return loader.countryList.filter { $0.name.lowercased().contains(searchText.lowercased()) || $0.capital.lowercased().contains(searchText.lowercased()) }
        }
    }
}
