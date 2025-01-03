//
//  SearchBar.swift
//  NearbyApp
//
//  Created by Emmanuel Biju on 03/01/25.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search", text: $text)
        }
        .padding(12.0)
        .cornerRadius(12.0)
        .overlay(
            RoundedRectangle(cornerRadius: 12.0)
                .stroke(lineWidth: 2.0)
                .foregroundColor(Color.gray))
    }
}

#Preview {
    @State var text = ""
    SearchBar(text: $text)
}
