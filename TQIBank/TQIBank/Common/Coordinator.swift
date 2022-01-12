//
//  Coordinator.swift
//  TQIBank
//
//  Created by Roberth Diorges on 12/01/22.
//

import UIKit

public protocol CoordinatorDelegate: AnyObject {
    func didFinish(_ coordinator: Coordinator)
}

extension CoordinatorDelegate {
    public func didFinish(_ coordinator: Coordinator) {}
}

public protocol Coordinator: CoordinatorDelegate {
    var delegate: CoordinatorDelegate? { get set }
    var childCoordinator: Coordinator? { get set }
    var viewController: UIViewController! { get set }
    var navigationController: UINavigationController? { get set }
    
    func stop()
    func start(usingPresenter presenter: CoordinatorPresenter, animated: Bool)
    func performStart(usingPresenter presenter: CoordinatorPresenter, animated: Bool)
    func didFinish(_ coordinator: Coordinator)
    
    func route(to coordinator: Coordinator, withPresenter presenter: CoordinatorPresenter, animated: Bool, delegate: CoordinatorDelegate?)
    func route(to location: RouterLocation, withPresenter presenter: CoordinatorPresenter, animated: Bool, delegate: CoordinatorDelegate?)
    
    // Deprecated
    @available(*, deprecated, message: "PBRouter configure Deprecated. Use PBRouter.register!")
    func route(to module: ModuleDestination, withPresenter presenter: CoordinatorPresenter, animated: Bool, delegate: CoordinatorDelegate?)
}

extension Coordinator {

    public func start(usingPresenter presenter: CoordinatorPresenter, animated: Bool = true) {
        performStart(usingPresenter: presenter, animated: animated)
    }
    
    public func performStart(usingPresenter presenter: CoordinatorPresenter, animated: Bool) {
        navigationController = presenter.present(destiny: viewController, animated: animated)
    }

    public func stop() {
        delegate = nil
        viewController = nil
        childCoordinator = nil
        navigationController = nil
    }
    
    public func didFinish(_ coordinator: Coordinator) {
        coordinator.stop()
        childCoordinator = nil
    }
    
    /**
     Route to Coordinator.
     
     - Parameters:
         - coordinator: The coordinator of the route
         - presenter: The Presenter Style of the show screen
         - animated: Using animated
         - delegate: Coordinator delegate
     
     ~~~
     let coordinator = InternalCoordinator()
     
     route(to: coordinator, withPresenter: .push(navigationViewController), animated: true)
     ~~~
     */
    public func route(to coordinator: Coordinator, withPresenter presenter: CoordinatorPresenter, animated: Bool = true, delegate: CoordinatorDelegate? = nil) {
        childCoordinator = coordinator
        coordinator.delegate = delegate ?? self
        coordinator.start(usingPresenter: presenter, animated: animated)
    }
    
    /**
     Route to location registered in PBRouter.
     
     - Parameters:
         - location: The Location of the route
         - presenter: The Presenter Style of the show screen
         - animated: Using animated
         - delegate: Coordinator delegate
     
     ~~~
     let location = RouterLocation(path: "route")
     
     route(to: location, withPresenter: .push(navigationViewController), animated: true)
     ~~~
     */
    public func route(to location: RouterLocation, withPresenter presenter: CoordinatorPresenter, animated: Bool, delegate: CoordinatorDelegate? = nil) {
        guard let coordinator = TQIRouter.coordinator(for: location) else {
            location.onError(.start(CoordinatorError.notFound))
            return
        }
        route(to: coordinator, withPresenter: presenter, animated: animated, delegate: delegate)
    }
    
    // Deprecated
    @available(*, deprecated, message: "PBRouter configure Deprecated. Use PBRouter.register!")
    public func route(to module: ModuleDestination, withPresenter presenter: CoordinatorPresenter, animated: Bool = true, delegate: CoordinatorDelegate? = nil) {
        let coordinator = TQIRouter.manager!.resolve(module: module)
        route(to: coordinator, withPresenter: presenter, animated: animated, delegate: delegate)
    }
}
