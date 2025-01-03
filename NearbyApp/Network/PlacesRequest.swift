//
//  PlacesRequest.swift
//  NearbyApp
//
//  Created by Emmanuel Biju on 03/01/25.
//

import CoreLocation

struct PlacesRequest: APIRequest {
    typealias Response = PlacesResponse
    
    let baseURL = "https://api.seatgeek.com"
    let path = "/2/venues"
    let page: Int
    let range: Int
    let location: CLLocation
    let searchQuery: String?
    let cliendId = "Mzg0OTc0Njl8MTcwMDgxMTg5NC44MDk2NjY5"
    
    var queryItems: [URLQueryItem] {
        var items = [
            URLQueryItem(name: "client_id", value: cliendId),
            URLQueryItem(name: "per_page", value: "10"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "range", value: "\(range)mi"),
            URLQueryItem(name: "lat", value: "\(location.coordinate.latitude)"),
            URLQueryItem(name: "lon", value: "\(location.coordinate.longitude)")
        ]
        if let search = searchQuery, !search.isEmpty {
            items.append(URLQueryItem(name: "q", value: search))
        }
        
        return items
    }
}
