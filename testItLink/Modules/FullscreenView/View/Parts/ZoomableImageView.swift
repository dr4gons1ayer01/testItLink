//
//  ZoomableImageView.swift
//  testItLink
//
//  Created by Иван Семенов on 27.04.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct ZoomableImageView: View {
    let url: URL
    @State private var scale: CGFloat = 1.0
    @State private var reloadKey = UUID()
    @State private var failed = false

    var body: some View {
        GeometryReader { proxy in
            if failed {
                VStack {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                    Text("Ошибка")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(width: proxy.size.width, height: proxy.size.height)
                .background(Color(UIColor.secondarySystemBackground))
                .onTapGesture {
                    failed = false
                    reloadKey = UUID()
                }
            } else {
                WebImage(url: url)
                    .onFailure { _ in
                        DispatchQueue.main.async {
                            failed = true
                        }
                    }
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(scale)
                    .id(reloadKey)
                    .gesture(MagnificationGesture()
                        .onChanged { value in
                            scale = value
                        }
                        .onEnded { _ in
                            withAnimation {
                                scale = 1.0
                            }
                        })
                    .frame(width: proxy.size.width, height: proxy.size.height)
            }
        }
        .onAppear {
            NetworkMonitor.shared.onChange = { newStatus in
                if newStatus && failed {
                    failed = false
                    reloadKey = UUID()
                }
            }
        }
    }
}
