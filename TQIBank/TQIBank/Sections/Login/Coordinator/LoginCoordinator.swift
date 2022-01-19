//
//  LoginCoordinator.swift
//  TQIBank
//
//  Created by Roberth Diorges on 11/01/22.
//

import UIKit

class LoginCoordinator {
    
    var window: UIWindow
    var viewModel: LoginViewModel?
    var loginViewController: LoginViewController?
    var navigationController: UINavigationController?
    
    var homeView: HomeViewController?
    var homeCoordinator: HomeViewCoordinator?
    
    required init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        viewModel = LoginViewModel()
        viewModel?.coordinatorDelegate = self
        loginViewController = LoginViewController(viewModel: viewModel!)
        
        navigationController = UINavigationController(rootViewController: loginViewController!)
        navigationController?.setNavigationBarHidden(true, animated: false)
        window.rootViewController = navigationController
    }
}

extension LoginCoordinator: LoginViewModelCoordinatorDelegate {
    func loginViewModelGoToHome(_ viewModel: LoginViewModel, user: User) {
        guard let navigation = self.navigationController else { return }
        homeCoordinator = HomeViewCoordinator()
        homeCoordinator?.start(usingPresentation: .push(navigation: navigation))
    }
}
