//
//  DetailPresenter.swift
//  MVP-Storyboard-3
//
//  Created by Ruslan on 12.02.2022.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func setComment(_ comment: Comment?)
}

protocol DetailPresenterProtocol: AnyObject {
    init(networkService: NetworkServiceProtocol, view: DetailViewProtocol, router: RouterProtocol, model: Comment?)
    func setComment()
    func tap()
}

class DetailPresenter: DetailPresenterProtocol {
    
    let networkService: NetworkServiceProtocol!
    weak var view: DetailViewProtocol?
    var router: RouterProtocol?
    var comment: Comment?
    
    required init(networkService: NetworkServiceProtocol, view: DetailViewProtocol, router: RouterProtocol, model: Comment?) {
        self.networkService = networkService
        self.view = view
        self.router = router
        self.comment = model
    }
    
    func tap() {
        router?.popToRootViewController()
    }
    
    func setComment() {
        view?.setComment(comment)
    }
}
