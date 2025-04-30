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
    private var selectedIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        updateNavigationBar()
        setupContent()
    }

    private func setupContent() {
        guard let presenter = presenter else { return }

        let contentView = FullscreenView(
            items: presenter.items,
            selectedIndex: Binding(
                get: { [weak self] in self?.selectedIndex ?? 0 },
                set: { [weak self] in self?.selectedIndex = $0 }
            ),
            isNavHidden: Binding(
                get: { [weak self] in self?.isNavHidden ?? false },
                set: { [weak self] in self?.isNavHidden = $0 }
            )
        )

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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(shareImage)
        )
    }

    @objc private func shareImage() {
        guard let url = presenter?.items[safe: selectedIndex]?.url else { return }
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(activityVC, animated: true)
    }
}
