//
//  HomeCoordinator.swift
//  TQIBank
//
//  Created by Roberth Diorges on 11/01/22.
//

import UIKit
import TQICoordinator
import TQIExtract

class HomeViewCoordinator: Coordinator {
   
    var navigation: UINavigationController?
    var presentationType: PresentationType?
    
    var viewModel: HomeViewModel?
    var view: HomeViewController?
    
    private var extractCoordinator: ExtractCoordinator?
    
    init() {
        viewModel = HomeViewModel()
        viewModel?.coordinatorDelegate = self
        view = HomeViewController(viewModel: viewModel!)
    }
    
    func stop() {
        navigation = nil
        presentationType = nil
        viewModel = nil
        view = nil
    }
}

extension HomeViewCoordinator: HomeViewModelCoordinatorDelegate {
    func homeViewModelGoToExtract(_ viewModel: HomeViewModel) {
        guard let navigation = navigation else { return }
        extractCoordinator = ExtractCoordinator()
        extractCoordinator?.start(usingPresentation: .push(navigation: navigation))
    }
}
