//
//  PlacesResponse.swift
//  NearbyApp
//
//  Created by Emmanuel Biju on 03/01/25.
//

struct PlacesResponse: Codable {
    let venues: [Place]
    let meta: PlacesMeta
}

struct PlacesMeta: Codable {
    let total: Int
    let per_page: Int
    let page: Int
}
