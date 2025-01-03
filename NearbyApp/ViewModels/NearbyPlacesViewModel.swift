//
//  NearbyPlacesViewModel.swift
//  NearbyApp
//
//  Created by Emmanuel Biju on 03/01/25.
//

import Foundation

@MainActor
class NearbyPlacesViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var places: [Place] = []
    @Published var isLoading: Bool = false
    @Published var error: String?
    @Published var distanceRange: Double = 5 // Keeping default as 5 KMs
    
    private var currentPage = 1
    private var hasMorePages = true
    private var isFetching = false
    
    private let locationManager: LocationManager
    
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
    }
        
    func loadPlaces(isRefreshing: Bool = false) async{
        guard !isFetching else { return }
        
        if isRefreshing {
            currentPage = 1
            places = []
            hasMorePages = true
        }
        
        guard hasMorePages else { return }
        
        isFetching = true
        isLoading = true
        error = nil
        
        do {
            let cacheKey = "\(currentPage)-\(distanceRange)-\(searchText)"
            if let cachedPlaces = await CacheManager.shared.getCachedPlaces(forKey: cacheKey) {
                if isRefreshing {
                    places = cachedPlaces
                } else {
                    places.append(contentsOf: cachedPlaces)
                }
                isLoading = false
                isFetching = false
                return
            }
            
            let response = try await NetworkManager.shared.fetchPlaces(page: currentPage, range: Int(distanceRange), location: locationManager.location, searchQuery: searchText.isEmpty ? nil : searchText)
            
            await CacheManager.shared.cachePlaces(response.venues, forKey: cacheKey)
            
            if isRefreshing {
                places = response.venues
            } else {
                places.append(contentsOf: response.venues)
            }
            
            hasMorePages = response.venues.count == 10
            currentPage += 1
        } catch {
            self.error = error.localizedDescription
        }
        
        isLoading = false
        isFetching = false
    }
    
    
    func refreshPlaces() async  {
        await loadPlaces(isRefreshing: true)
    }
    
    func updateDistanceRange(_ range: Double) {
        distanceRange = range
        Task {
            await refreshPlaces()
        }
    }
    
    func searchPlaces() async {
        await refreshPlaces()
    }
}
