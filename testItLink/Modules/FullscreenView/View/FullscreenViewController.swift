//
//  FullscreenViewController.swift
//  testItLink
//
//  Created by Иван Семенов on 27.04.2025.
//

import UIKit
import SwiftUI

protocol FullscreenViewControllerProtocol: BaseViewProtocol {
    
}

final class FullscreenViewController: UIViewController, FullscreenViewControllerProtocol {
    typealias PresenterType = FullscreenViewPresenterProtocol
    var presenter: PresenterType?
    private var hostingController: UIHostingController<FullscreenView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        setupContent()
    }
    
    private func setupContent() {
        guard let presenter = presenter else { return }
        
        let contentView = FullscreenView(items: presenter.items, selectedIndex: presenter.selectedIndex)
        
        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.frame
        content.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(content.view)
        content.didMove(toParent: self)
        self.hostingController = content
    }
}
