//
//  RequestLocationAccessView.swift
//  NearbyApp
//
//  Created by Emmanuel Biju on 03/01/25.
//

import SwiftUI

struct RequestLocationAccessView: View {
    let locationManager: LocationManager
        
        var body: some View {
            VStack {
                Image(systemName: "location.circle")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                
                Text("Please Allow Location Access")
                    .font(.title2)
                    .padding()
                
                Text("This app needs your location to find venues near you.")
                    .multilineTextAlignment(.center)
                    .padding()
                
                Button("Request Location") {
                    locationManager.requestLocation()
                }
                .padding()
            }
        }
}
