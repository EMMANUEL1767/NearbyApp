//
//  LocationManager.swift
//  NearbyApp
//
//  Created by Emmanuel Biju on 03/01/25.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var location: CLLocation?
    @Published var error: Error?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        self.error = error
    }
}
