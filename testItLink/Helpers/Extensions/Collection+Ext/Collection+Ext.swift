//
//  Collection+Ext.swift
//  testItLink
//
//  Created by Иван Семенов on 30.04.2025.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
