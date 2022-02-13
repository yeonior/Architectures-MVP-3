//
//  MainPresenterTest.swift
//  MVP-Storyboard-3Tests
//
//  Created by Ruslan on 13.02.2022.
//

import XCTest
@testable import MVP_Storyboard_3

class MockView: MainViewProtocol {
    func success() {
        
    }
    
    func failure(error: Error) {
        
    }
}

class MockNetworkService: NetworkServiceProtocol {
    
    var comments: [Comment]!
    
    init(comments: [Comment]?) {
        self.comments = comments
    }
    
    func getComments(completion: @escaping (Result<[Comment]?, Error>) -> Void) {
        if let comments = comments {
            completion(.success(comments))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
}

class MainPresenterTest: XCTestCase {
    
    var view: MockView!
    var presenter: MainPresenter!
    var networkService: NetworkServiceProtocol!
    var router: RouterProtocol!
    var comments = [Comment]()

    override func setUpWithError() throws {
        let navigationController = UINavigationController()
        let assemblyBuilder = AssemblyBuilder()
        router = Router(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
        router.initialViewController()
    }

    override func tearDownWithError() throws {
        view = nil
        networkService = nil
        presenter = nil
    }
    
    func testGetSuccessComments() {
        let comment = Comment(postId: 1, id: 2, name: "Foo", email: "Baz", body: "Bar")
        comments.append(comment)
        
        view = MockView()
        networkService = MockNetworkService(comments: [comment])
        presenter = MainPresenter(networkService: networkService, view: view, router: router)
        
        var catchedComments: [Comment]?
        
        networkService.getComments { result in
            switch result {
            case .success(let comments):
                catchedComments = comments
            case .failure(let error):
                print(error)
            }
        }
        
        XCTAssertNotEqual(catchedComments?.count, 0)
    }
}
