//
//  GalleryViewController.swift
//  testItLink
//
//  Created by Иван Семенов on 27.04.2025.
//

import UIKit
import SwiftUI

protocol GalleryViewControllerProtocol: BaseViewProtocol {
    
}

class GalleryViewController: UIViewController, GalleryViewControllerProtocol {
    typealias PresenterType = GalleryViewPresenterProtocol
    var presenter: PresenterType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentView = GalleryView()
        
        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.frame
        view.addSubview(content.view)
        content.didMove(toParent: self)
    }
}
