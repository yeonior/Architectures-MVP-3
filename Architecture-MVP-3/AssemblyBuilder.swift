//
//  ModuleBuilder.swift
//  Architecture-MVP-3
//
//  Created by Ruslan on 11.02.2022.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(comment: Comment?, router: RouterProtocol) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        
        let networkService = NetworkService()
        let view = MainViewController()
        let presenter = MainPresenter(networkService: networkService, view: view, router: router)
        
        view.presenter = presenter
        
        return view
    }
    
    func createDetailModule(comment: Comment?, router: RouterProtocol) -> UIViewController {
        
        let networkService = NetworkService()
        let view = DetailViewController()
        let presenter = DetailPresenter(networkService: networkService, view: view, router: router, model: comment)
        
        view.presenter = presenter
        
        return view
    }
}
