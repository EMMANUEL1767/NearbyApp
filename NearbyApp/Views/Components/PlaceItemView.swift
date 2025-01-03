//
//  PlaceItemView.swift
//  NearbyApp
//
//  Created by Emmanuel Biju on 03/01/25.
//

import SwiftUI

struct PlaceItemView: View {
    let place: Place
    
    var body: some View {
        Link(destination: URL(string: place.url ?? "")!) {
            VStack(alignment: .leading, spacing: 8) {
                Text(place.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(place.city ?? "Unnamed city")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(place.country ?? "Unnamed city")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(place.address ?? "")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 8)
        }
    }
}
