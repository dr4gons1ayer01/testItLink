//
//  FullscreenView.swift
//  testItLink
//
//  Created by Иван Семенов on 27.04.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct FullscreenView: View {
    let items: [ImageItem]
    @Binding var selectedIndex: Int
    @Binding var isNavHidden: Bool

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
