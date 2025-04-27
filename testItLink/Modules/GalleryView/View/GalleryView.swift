//
//  GalleryView.swift
//  testItLink
//
//  Created by Иван Семенов on 27.04.2025.
//

import SwiftUI

struct GalleryView: View {
    var items: [ImageItem]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 8) {
                ForEach(items) { item in
                    AsyncImage(url: item.url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                            .frame(width: 100, height: 100)
                    }
                }
            }
            .padding()
        }
    }
}
