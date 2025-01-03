//
//  NetworkManager.swift
//  NearbyApp
//
//  Created by Emmanuel Biju on 03/01/25.
//

import Foundation
import CoreLocation

protocol APIRequest {
    associatedtype Response: Decodable
    var baseURL: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension APIRequest {
    func fetch() async throws -> Response {
        var components = URLComponents(string: baseURL)!
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError("Invalid response")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Response.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchPlaces(page: Int, range: Int, location: CLLocation?, searchQuery: String? = nil) async throws -> PlacesResponse {
        guard let location = location else {
            throw NetworkError.locationNotAvailable
        }
        
        let request = PlacesRequest(page: page, range: range, location: location, searchQuery: searchQuery)
        
        return try await request.fetch()
    }
}
