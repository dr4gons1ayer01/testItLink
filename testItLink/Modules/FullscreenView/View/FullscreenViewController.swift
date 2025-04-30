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
    private var isNavHidden: Bool = false {
        didSet {
            updateNavigationBar()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        updateNavigationBar()
        setupContent()
    }
    
    private func setupContent() {
        guard let presenter = presenter else { return }
        
        let contentView = FullscreenView(items: presenter.items,
                                         selectedIndex: presenter.selectedIndex,
                                         isNavHidden: Binding(
                                            get: { [weak self] in self?.isNavHidden ?? false },
                                            set: { [weak self] newValue in self?.isNavHidden = newValue }
                                         ))
        
        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.frame
        content.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(content.view)
        content.didMove(toParent: self)
        self.hostingController = content
    }
    
    private func updateNavigationBar() {
        navigationItem.hidesBackButton = isNavHidden
        navigationController?.navigationBar.alpha = isNavHidden ? 0 : 1
    }
}
