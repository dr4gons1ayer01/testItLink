//
//  String+Ext.swift
//  testItLink
//
//  Created by Иван Семенов on 27.04.2025.
//

import Foundation

extension String {
    var matchesImage: Bool {
        ["jpg", "jpeg", "png", "gif"].contains(self)
    }
}
