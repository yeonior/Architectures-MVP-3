//
//  RouterTest.swift
//  Architecture-MVP-3Tests
//
//  Created by Ruslan on 14.02.2022.
//

import XCTest
@testable import Architecture_MVP_3

class MockNavigationController: UINavigationController {
    
    var presentedVC: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}

class RouterTest: XCTestCase {
    
    var router: RouterProtocol!
    let navigationController = MockNavigationController()
    let assemblyBuilder = AssemblyBuilder()

    override func setUpWithError() throws {
        router = Router(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
    }

    override func tearDownWithError() throws {
        router = nil
    }
    
    func testRouter() {
        router.showDetailViewController(comment: nil)
        let detailVC = navigationController.presentedVC
        XCTAssertTrue(detailVC is DetailViewController)
    }
}
