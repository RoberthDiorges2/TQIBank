//
//  HomeViewModel.swift
//  TQIBank
//
//  Created by Roberth Diorges on 11/01/22.
//

import VFNetwork

protocol HomeViewModelViewDelegate: AnyObject {
    func homeViewModelSuccess(_ viewModel: HomeViewModel)
    func homeViewModelFailure(_ viewModel: HomeViewModel, error: Error)
}

class HomeViewModel {
    
    weak var viewDelegate: HomeViewModelViewDelegate?
    var model: MenuOptions
    public let service: HomeService
    
    public init(model: MenuOptions = .init(), service: HomeService = .init()) {
        self.model = model
        self.service = service
    }
    
    public func getMenuOptions() {
        service.getMenus { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(model):
                self.model = model
                self.viewDelegate?.homeViewModelSuccess(self)
            case let .failure(error):
                self.viewDelegate?.homeViewModelFailure(self, error: error)
            }
        }
    }
}
