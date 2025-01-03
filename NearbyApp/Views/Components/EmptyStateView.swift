//
//  EmptyStateView.swift
//  NearbyApp
//
//  Created by Emmanuel Biju on 03/01/25.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "mappin.slash")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.gray)
            
            Text("No Venues Found")
                .font(.title2)
            
            Text("Try adjusting your search or distance settings")
                .foregroundColor(.secondary)
        }
        .padding()
    }
}
