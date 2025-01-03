//
//  CacheManager.swift
//  NearbyApp
//
//  Created by Emmanuel Biju on 03/01/25.
//

import Foundation

actor CacheManager {
    static let shared = CacheManager()
    private var cache: NSCache<NSString, NSArray>
    
    private init() {
        cache = NSCache<NSString, NSArray>()
        cache.countLimit = 100
    }
    
    func cachePlaces(_ places: [Place], forKey key: String) {
        cache.setObject(places as NSArray, forKey: key as NSString)
    }
    
    func getCachedPlaces(forKey key: String) -> [Place]? {
        return cache.object(forKey: key as NSString) as? [Place]
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
}
