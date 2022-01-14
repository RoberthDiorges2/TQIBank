//
//  LoginViewModel.swift
//  TQIBank
//
//  Created by Roberth Diorges on 11/01/22.
//

import Foundation
import VFNetwork

// MARK: Protocols
protocol LoginViewModelCoordinatorDelegate: AnyObject {
    func loginViewModelGoToHome(_ viewModel: LoginViewModel, user: User)
}

protocol LoginViewModelViewDelegate: AnyObject {
    func loginViewModelShowLoading(_ viewModel: LoginViewModel, showLoading: Bool)
}

class LoginViewModel {
    
    // MARK: Properties
    weak var coordinatorDelegate: LoginViewModelCoordinatorDelegate?
    weak var viewDelegate: LoginViewModelViewDelegate?
    public let service: LoginService
    
    // MARK: Initializer
    
    public init(service: LoginService = .init()) {
        self.service = service
    }
    
    public func postAuthenticate(userName: String, password: String) {
        
        service.postAuthenticate(userName: userName, password: password) { result in
            self.viewDelegate?.loginViewModelShowLoading(self, showLoading: false)
            switch result {
            case let .success(user):
                self.coordinatorDelegate?.loginViewModelGoToHome(self, user: user)
            case let .failure(error):
                debugPrint(error)
            }
        }
    }
}
