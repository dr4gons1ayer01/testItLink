//
//  GalleryView.swift
//  testItLink
//
//  Created by Иван Семенов on 27.04.2025.
//

import SwiftUI

struct GalleryView: View {
    var items: [ImageItem]
    var onSelect: (ImageItem, Int) -> Void
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 8) {
                ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                    AsyncImage(url: item.url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 110, height: 110)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 110, height: 110)
                                .clipped()
                                .cornerRadius(8)
                        case .failure:
                            VStack {
                                Image(systemName: "photo.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.gray)
                                Text("Ошибка")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .frame(width: 110, height: 110)
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(8)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        onSelect(item, index)
                    }
                }
            }
            .padding()
        }
    }
}
