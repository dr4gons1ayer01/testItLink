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
                    RetryableImageView(url: item.url, size: 110) {
                        onSelect(item, index)
                    }
                }
            }
            .padding()
        }
    }
}
