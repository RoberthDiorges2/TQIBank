//
//  LoginViewModelTests.swift
//  TQIBankTests
//
//  Created by Cristino Divino on 27/01/22.
//

import XCTest
import VFNetwork
@testable import TQIBank
class LoginViewModelTests: XCTestCase {
    
    var viewModel: LoginViewModel!
    var mock: JSONMockOrchestrator!
    
    var goToHome = false
    
    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel()
        mock = JSONMockOrchestrator()
        let provider = RequestProvider<LoginAPI>()
        provider.executor.orchestrator = mock
        viewModel.service.provider = provider
        viewModel.viewDelegate = self
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        mock = nil
    }
    
    func testPostAuthenticateSuccess() {
        let expectation = self.expectation(description: "Testar sucesso da chamada do login")
        let user = "tqi@mail.com"
        let password = "tqi123"
        mock.register(fileNamed: "login_response_success")
        viewModel.service.postAuthenticate(userName: user, password: password) { result in
            switch result {
            case let .success(user):
                XCTAssertNotNil(user)
                XCTAssertTrue(self.goToHome)
                expectation.fulfill()
            case .failure:
                XCTFail()
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testPostAuthenticateFailure() {
        let expectation = self.expectation(description: "Testar retorno de falha da chamada do login")
        let user = "acelera@mail.com"
        let password = "123456"
        mock.register(fileNamed: "login_response_failure", statusCode: 500)
        viewModel.service.postAuthenticate(userName: user, password: password) { result in
            switch result {
            case .success:
                XCTFail()
                expectation.fulfill()
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
}
extension LoginViewModelTests:LoginViewModelCoordinatorDelegate {
    func loginViewModelGoToHome(_ viewModel: LoginViewModel, user: User) {
        goToHome = true
    }
}

extension LoginViewModelTests: LoginViewModelViewDelegate {
    func loginViewModelShowLoading(_ viewModel: LoginViewModel, showLoading: Bool) {
        
    }
}
