//
//  FullscreenViewPresenter.swift
//  testItLink
//
//  Created by Иван Семенов on 27.04.2025.
//

import Foundation

protocol FullscreenViewPresenterProtocol: AnyObject {
    var items: [ImageItem] { get }
    var selectedIndex: Int { get }
}

final class FullscreenViewPresenter: FullscreenViewPresenterProtocol {
    private (set) var items: [ImageItem]
    private (set) var selectedIndex: Int
    
    init(items: [ImageItem], selectedIndex: Int) {
        self.items = items
        self.selectedIndex = selectedIndex
    }
}
