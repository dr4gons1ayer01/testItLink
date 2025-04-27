//
//  GalleryView.swift
//  testItLink
//
//  Created by Иван Семенов on 27.04.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct GalleryView: View {
    var items: [ImageItem]
    var onSelect: (ImageItem, Int) -> Void
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 8) {
                ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                    WebImage(url: item.url)
                        .resizable()
                        .indicator(.progress)
                        .transition(.fade(duration: 0.5))
                        .scaledToFill()
                        .frame(width: 110, height: 110)
                        .clipped()
                        .cornerRadius(8)
                        .onTapGesture {
                            onSelect(item, index)
                        }
                }
            }
            .padding()
        }
    }
}
