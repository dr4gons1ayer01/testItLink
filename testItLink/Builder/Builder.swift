//
//  Builder.swift
//  testItLink
//
//  Created by Иван Семенов on 27.04.2025.
//

import UIKit

protocol BaseViewProtocol: AnyObject {
    associatedtype PresenterType
    var presenter: PresenterType? { get set }
}

class Builder {
    //view
    //presenter
    
    static private func createView<View: UIViewController & BaseViewProtocol>(viewType: View.Type, presenter: (View) -> View.PresenterType) -> UIViewController {
        let view = View()
        let presenter = presenter(view)
        view.presenter = presenter
        return view
    }
    
    static func createGalleryView() -> UIViewController {
        let galleryVC = createView(viewType: GalleryViewController.self) { view in
            GalleryViewPresenter(view: view)
        }
        return UINavigationController(rootViewController: galleryVC)
    }
    
    static func createFullscreenView(items: [ImageItem], selectedIndex: Int) -> UIViewController {
        return createView(viewType: FullscreenViewController.self) { view in
            FullscreenViewPresenter(items: items, selectedIndex: selectedIndex)
        }
    }
}
