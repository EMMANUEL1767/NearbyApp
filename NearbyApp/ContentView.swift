//
//  ContentView.swift
//  NearbyApp
//
//  Created by Emmanuel Biju on 03/01/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        Group {
            if locationManager.location != nil {
                NearbyPlacesView(locationManager: locationManager)
            } else {
                RequestLocationAccessView(locationManager: locationManager)
            }
        }
    }
}
