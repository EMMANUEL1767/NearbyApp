//
//  NearbyPlacesView.swift
//  NearbyApp
//
//  Created by Emmanuel Biju on 03/01/25.
//

import SwiftUI

struct NearbyPlacesView: View {
    @StateObject private var viewModel: NearbyPlacesViewModel
        @State private var searchText = ""
        
        init(locationManager: LocationManager) {
            _viewModel = StateObject(wrappedValue: NearbyPlacesViewModel(locationManager: locationManager))
        }
        
        var body: some View {
            NavigationView {
                VStack {
                    SearchBar(text: $searchText)
                        .onChange(of: searchText) { _ in
                            Task {
                                await viewModel.searchPlaces()
                            }
                        }
                        .padding(16)
                        .background(Color.indigo.opacity(0.3))
                    
                    
                    
                    if viewModel.places.isEmpty && !viewModel.isLoading {
                        EmptyStateView()
                            .frame(maxHeight: .infinity, alignment: .center)
                    } else {
                        List {
                            ForEach(viewModel.places, id: \.id) { place in
                                PlaceItemView(place: place)
                                    .onAppear {
                                        if place.id == viewModel.places.last?.id {
                                            Task {
                                                await viewModel.loadPlaces()
                                            }
                                        }
                                    }
                            }
                            
                            if viewModel.isLoading {
                                ProgressView()
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .listStyle(PlainListStyle())
                        .refreshable {
                            await viewModel.refreshPlaces()
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Maximum Distance: \(Int(viewModel.distanceRange)) miles")
                            .font(.subheadline)
                        
                        Slider(value: Binding(
                            get: { viewModel.distanceRange },
                            set: { viewModel.updateDistanceRange($0) }
                        ), in: 1...50, step: 1)
                    }
                    .padding()
                }
                .navigationTitle("Nearby Venues")
                .alert("Error", isPresented: Binding(
                    get: { viewModel.error != nil },
                    set: { if !$0 { viewModel.error = nil } }
                )) {
                    Button("OK") {
                        viewModel.error = nil
                    }
                } message: {
                    Text(viewModel.error ?? "")
                }
            }
            .task {
                await viewModel.loadPlaces()
            }
        }
}


