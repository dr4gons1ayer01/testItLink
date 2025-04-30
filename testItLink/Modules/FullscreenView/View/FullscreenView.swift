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
    @Binding var isNavHidden: Bool
    @Environment(\.presentationMode) var presentationMode
    
    init(items: [ImageItem], selectedIndex: Int, isNavHidden: Binding<Bool>) {
        self.items = items
        _selectedIndex = State(initialValue: selectedIndex)
        _isNavHidden = isNavHidden
    }
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            ForEach(items.indices, id: \.self) { index in
                ZoomableImageView(url: items[index].url)
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .background(Color(.systemBackground).ignoresSafeArea())
        .onTapGesture {
            isNavHidden.toggle()
        }
    }
}
