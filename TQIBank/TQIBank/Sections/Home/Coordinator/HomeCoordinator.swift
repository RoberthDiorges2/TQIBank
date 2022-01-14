//
//  HomeCoordinator.swift
//  TQIBank
//
//  Created by Roberth Diorges on 11/01/22.
//

import UIKit

class HomeViewCoordinator: Coordinator {
    
    var delegate: CoordinatorDelegate?
    var childCoordinator: Coordinator?
    var viewController: UIViewController!
    var navigationController: UINavigationController?
    
    var viewModel: HomeViewModel?
    var view: HomeViewController?
    
    init() {
        
        viewModel = HomeViewModel()
        view = HomeViewController(viewModel: viewModel!)
        viewController = view
        
        navigationController = UINavigationController(rootViewController: viewController)
    }
    
    func start() {
        
    }
}
