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
        return createView(viewType: GalleryViewController.self) { view in
            GalleryViewPresenter(view: view)
        }
    }
}
