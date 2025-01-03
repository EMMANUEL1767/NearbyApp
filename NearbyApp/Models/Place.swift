//
//  Place.swift
//  NearbyApp
//
//  Created by Emmanuel Biju on 03/01/25.
//

import Foundation

struct Place: Codable {
    let id: Int
    let name: String
    let nameV2: String?
    let postalCode: String?
    let timezone: String?
    let score: Double?
    let popularity: Int?
    let address: String?
    let country: String?
    let city: String?
    let state: String?
    let slug: String?
    let location: GeoLocation?
    let extendedAddress: String?
    let url: String?
    let displayLocation: String?
    
    enum Codingkeys: String, CodingKey {
        case id
        case name
        case nameV2 = "name_v2"
        case postalCode = "postal_code"
        case timezone
        case score
        case popularity
        case address
        case country
        case city
        case state
        case slug
        case location
        case extendedAddresss = "extended_address"
        case url
        case displayLocation = "display_location"
    }
}

