//
//  GalleryViewController.swift
//  testItLink
//
//  Created by Иван Семенов on 27.04.2025.
//

import UIKit
import SwiftUI

protocol GalleryViewControllerProtocol: BaseViewProtocol {
    func updateGallery(with items: [ImageItem])
}

class GalleryViewController: UIViewController, GalleryViewControllerProtocol {
    typealias PresenterType = GalleryViewPresenterProtocol
    var presenter: PresenterType?
    private var items: [ImageItem] = []
    private var hostingController: UIHostingController<GalleryView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        presenter?.loadImages()
    }
    
    func updateGallery(with items: [ImageItem]) {
        self.items = items
        let contentView = GalleryView(items: items) { [weak self] item, index in
            self?.showFullScreen(items: items, selectedIndex: index)
        }
        
        if let hostingController {
            hostingController.rootView = contentView
        } else {
            let content = UIHostingController(rootView: contentView)
            addChild(content)
            view.addSubview(content.view)
            content.view.frame = view.bounds
            content.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            content.didMove(toParent: self)
            self.hostingController = content
        }
    }

    private func showFullScreen(items: [ImageItem], selectedIndex: Int) {
        let fullscreenVC = Builder.createFullscreenView(items: items, selectedIndex: selectedIndex)
        navigationController?.pushViewController(fullscreenVC, animated: true)
    }
}
