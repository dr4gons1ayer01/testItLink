//
//  RetryableImageView.swift
//  testItLink
//
//  Created by Иван Семенов on 30.04.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct RetryableImageView: View {
    let url: URL
    let size: CGFloat
    let onSelect: () -> Void

    @State private var reloadKey = UUID()
    @State private var failed = false

    var body: some View {
        if failed {
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
            .frame(width: size, height: size)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(8)
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
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFill()
                .frame(width: size, height: size)
                .clipped()
                .cornerRadius(8)
                .onTapGesture {
                    onSelect()
                }
                .id(reloadKey)
        }
    }
}
