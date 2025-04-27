//
//  GalleryViewPresenter.swift
//  testItLink
//
//  Created by Иван Семенов on 27.04.2025.
//

import Foundation

protocol GalleryViewPresenterProtocol: AnyObject {
    
}

class GalleryViewPresenter: GalleryViewPresenterProtocol {
    weak var view: (any GalleryViewControllerProtocol)?
    
    init(view: any GalleryViewControllerProtocol) {
        self.view = view
    }
}
