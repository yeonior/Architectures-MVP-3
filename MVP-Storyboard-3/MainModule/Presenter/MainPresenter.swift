//
//  MainPresenter.swift
//  MVP-Storyboard-3
//
//  Created by Ruslan on 11.02.2022.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol MainPresenterProtocol: AnyObject {
    init(networkService: NetworkServiceProtocol, view: MainViewProtocol, router: RouterProtocol)
    var comments: [Comment]? { get set }
    func getComments()
    func tapOnTheComment(_ comment: Comment?)
}

class MainPresenter: MainPresenterProtocol {
    
    let networkService: NetworkServiceProtocol!
    weak var view: MainViewProtocol?
    var router: RouterProtocol?
    var comments: [Comment]?
    
    required init(networkService: NetworkServiceProtocol, view: MainViewProtocol, router: RouterProtocol) {
        self.networkService = networkService
        self.view = view
        self.router = router
        getComments()
    }
    
    func tapOnTheComment(_ comment: Comment?) {
        router?.showDetailViewController(comment: comment)
    }
    
    func getComments() {
        networkService.getComments { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let comments):
                    self.comments = comments
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}
