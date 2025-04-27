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
        let contentView = GalleryView(items: items)
        
        if let hostingController {
            hostingController.rootView = contentView
        } else {
            let hosting = UIHostingController(rootView: contentView)
            addChild(hosting)
            view.addSubview(hosting.view)
            hosting.view.frame = view.bounds
            hosting.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            hosting.didMove(toParent: self)
            self.hostingController = hosting
        }
    }
}
