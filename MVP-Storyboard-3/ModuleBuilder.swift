//
//  ModuleBuilder.swift
//  MVP-Storyboard-3
//
//  Created by Ruslan on 11.02.2022.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
    static func createDetailModule(comment: Comment?) -> UIViewController
}

class ModuleBuilder: Builder {
    
    static func createMainModule() -> UIViewController {
        
        let networkService = NetworkService()
        let view = MainViewController()
        let presenter = MainPresenter(networkService: networkService, view: view)
        
        view.presenter = presenter
        
        return view
    }
    
    static func createDetailModule(comment: Comment?) -> UIViewController {
        
        let networkService = NetworkService()
        let view = DetailViewController()
        let presenter = DetailPresenter(networkService: networkService, view: view, model: comment)
        
        view.presenter = presenter
        
        return view
    }
}
