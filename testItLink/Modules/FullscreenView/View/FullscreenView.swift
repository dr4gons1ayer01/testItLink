//
//  FullscreenView.swift
//  testItLink
//
//  Created by Иван Семенов on 27.04.2025.
//

import SwiftUI

struct FullscreenView: View {
    let items: [ImageItem]
    @State private var selectedIndex: Int
    @State private var scale: CGFloat = 1.0
    @Environment(\.presentationMode) var presentationMode
    
    init(items: [ImageItem], selectedIndex: Int) {
        self.items = items
        _selectedIndex = State(initialValue: selectedIndex)
    }
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            ForEach(items.indices, id: \.self) { index in
                ZoomableImageView(url: items[index].url)
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .background(Color(.systemBackground).ignoresSafeArea())
    }
}
