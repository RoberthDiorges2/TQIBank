//
//  CoordinatorPresenter.swift
//  TQIBank
//
//  Created by Roberth Diorges on 12/01/22.
//

import UIKit

public protocol CoordinatorPresenterProtocol {
    var rootViewController: UIViewController { get }
    func present(destiny destinyViewController: UIViewController, animated: Bool) -> UINavigationController
}

public enum CoordinatorPresenter: CoordinatorPresenterProtocol {
    case push(UINavigationController)
    case present(UIViewController, UIModalPresentationStyle = .fullScreen)
    case custom(CoordinatorPresenterProtocol)
}

extension CoordinatorPresenter {
    public var rootViewController: UIViewController {
        switch self {
        case .push(let navigationController): return navigationController
        case .present(let viewController, let style): return viewController
        case .custom(let presenter): return presenter.rootViewController
        }
    }
    
    public func present(destiny destinyViewController: UIViewController, animated: Bool) -> UINavigationController {
        switch self {
        case .push(let navigationController):
            return pushStart(navigationController: navigationController, destiny: destinyViewController, animated: animated)
        case .present(let viewController, let style):
            return presentStart(viewController: viewController, style: style, destiny: destinyViewController, animated: animated)
        case .custom(let presenter):
            return presenter.present(destiny: destinyViewController, animated: animated)
        }
    }
}

private extension CoordinatorPresenter {
    func pushStart(navigationController: UINavigationController, destiny destinyViewController: UIViewController, animated: Bool) -> UINavigationController {
        navigationController.pushViewController(destinyViewController, animated: animated)
        return navigationController
    }
    
    func presentStart(viewController: UIViewController, style: UIModalPresentationStyle, destiny destinyViewController: UIViewController, animated: Bool) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: destinyViewController)
        navigationController.modalPresentationStyle = style
        viewController.present(navigationController, animated: animated, completion: nil)
        return navigationController
    }
}
