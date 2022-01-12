//
//  AppCoordinator.swift
//  TQIBank
//
//  Created by Roberth Diorges on 11/01/22.
//

import UIKit

class AppCoordinator {
    
    var window: UIWindow
    var loginCoordinator: LoginCoordinator?
    var viewModel: LoginViewModel?
    var loginViewController: LoginViewController?
    
    required init(window: UIWindow) {
        self.window = window
        self.window.makeKeyAndVisible()
    }
    
    func start() {
        viewModel = LoginViewModel()
        loginViewController = LoginViewController(viewModel: viewModel!)
        loginCoordinator = LoginCoordinator(window: self.window)
        window.rootViewController = loginViewController
    }
}

