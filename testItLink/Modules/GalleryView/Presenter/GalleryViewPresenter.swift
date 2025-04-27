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
    private let manager: DownloadManagingProtocol
    private var networkMonitor: NetworkMonitoringProtocol
    
    init(
        view: any GalleryViewControllerProtocol,
        manager: DownloadManagingProtocol = DownloadManager.shared,
        networkMonitor: NetworkMonitoringProtocol = NetworkMonitor.shared
    ) {
        self.view = view
        self.manager = manager
        self.networkMonitor = networkMonitor
        observeNetwork()
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
    
    private func observeNetwork() {
        networkMonitor.onChange = { [weak self] isConnected in
            guard let self = self else { return }
            if isConnected {
                self.loadImages()
            }
        }
    }
}
