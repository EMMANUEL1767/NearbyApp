//
//  NetworkError+Enum.swift
//  NearbyApp
//
//  Created by Emmanuel Biju on 03/01/25.
//

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case locationNotAvailable
    case serverError(String)
}

