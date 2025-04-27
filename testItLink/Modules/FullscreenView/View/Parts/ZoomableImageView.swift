//
//  ZoomableImageView.swift
//  testItLink
//
//  Created by Иван Семенов on 27.04.2025.
//

import SwiftUI

struct ZoomableImageView: View {
    let url: URL
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        GeometryReader { proxy in
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: proxy.size.width, height: proxy.size.height)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(scale)
                        .gesture(MagnificationGesture()
                            .onChanged { value in
                                scale = value
                            }
                            .onEnded { _ in
                                withAnimation {
                                    scale = 1.0
                                }
                            }
                        )
                        .frame(width: proxy.size.width, height: proxy.size.height)
                case .failure:
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .frame(width: 100, height: 100)
                        .background(.background)
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}
