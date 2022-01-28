//
//  HomeViewModelTests.swift
//  TQIBankTests
//
//  Created by Cristino Divino on 27/01/22.
//

import XCTest
import VFNetwork
@testable import TQIBank

class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    var mock: JSONMockOrchestrator!
    
    var model: MenuOptions = .init()
    let service: HomeService = .init()
    
    var goToExtract = false
    
    var getMenuOptionsSuccess: ((_ response: MenuOptions) -> Void)?
    var getMenuOptionsFailure: ((_ error: Error) -> Void)?
    

    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel(model: model, service: service)
        mock = JSONMockOrchestrator()
        let provider = RequestProvider<HomeAPI>()
        provider.executor.orchestrator = mock
        viewModel.service.provider = provider
        viewModel.viewDelegate = self
        viewModel.coordinatorDelegate = self
    }

    override func tearDown() {
        super.tearDown()
        mock = nil
        viewModel = nil
    }
    
    func testGoToExtract() {
        viewModel.goToExtract()
        XCTAssertTrue(goToExtract)
    }
    
    func testGetMenuOptionsSuccess() {
        let expectation = self.expectation(description: "Get Menu Options Success")
        mock.register(fileNamed: "get_menu_response_success")
        
        getMenuOptionsSuccess = { response in
            XCTAssertNotNil(response)
            XCTAssertEqual(response.menuOptions.first?.name, "Extrato")
            XCTAssertEqual(response.menuOptions.first?.type.rawValue, "EXTRACT")
            expectation.fulfill()
        }
        
        viewModel.getMenuOptions()
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testGetMenuOptionsFailure() {
        let expectation = self.expectation(description: "Get Menu Options Failure")
        mock.register(fileNamed: "", statusCode: 500)
        
        getMenuOptionsFailure = { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        viewModel.getMenuOptions()
        waitForExpectations(timeout: 10.0, handler: nil)
    }

}

extension HomeViewModelTests: HomeViewModelCoordinatorDelegate {
    func homeViewModelGoToExtract(_ viewModel: HomeViewModel) {
        goToExtract = true
    }
}

extension HomeViewModelTests: HomeViewModelViewDelegate {
    func homeViewModelSuccess(_ viewModel: HomeViewModel) {
        let response = viewModel.model
        getMenuOptionsSuccess?(response)
    }
    
    func homeViewModelFailure(_ viewModel: HomeViewModel, error: Error) {
        getMenuOptionsFailure?(error)
    }
}


