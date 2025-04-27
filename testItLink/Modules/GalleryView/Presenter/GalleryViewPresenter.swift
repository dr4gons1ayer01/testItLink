//
//  GalleryViewPresenter.swift
//  testItLink
//
//  Created by Иван Семенов on 27.04.2025.
//

import Foundation

protocol GalleryViewPresenterProtocol: AnyObject {
    func loadImages()
}

class GalleryViewPresenter: GalleryViewPresenterProtocol {
    weak var view: (any GalleryViewControllerProtocol)?
    private let manager: DownloadManager
    
    init(view: any GalleryViewControllerProtocol, manager: DownloadManager = .shared) {
        self.view = view
        self.manager = manager
    }
    
    func loadImages() {
        manager.loadFile { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let urls):
                let images = urls.map { ImageItem(url: $0) }
                DispatchQueue.main.async {
                    self.view?.updateGallery(with: images)
                }
            case .failure(let error):
                //todo: alert
                print(error.localizedDescription)
            }
        }
    }
}
