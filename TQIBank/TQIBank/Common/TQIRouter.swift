//
//  TQIRouter.swift
//  TQIBank
//
//  Created by Roberth Diorges on 12/01/22.
//

@available(*, deprecated, message: "CoordinatorManager Deprecated. Use PBRouter.coordinator!")
public protocol CoordinatorManagerProtocol  {
    func resolve(module: ModuleDestination) -> Coordinator
}

public protocol RouterDelegate {
    func coordinator(for location: RouterLocation) -> Coordinator?
}

public struct TQIRouter {
    
    static var routes: [String : RouterDelegate] = [:]
    
    public static func register(route: String, routerDelegate: RouterDelegate) {
        guard !TQIRouter.routes.contains(where: { $0.key == route }) else {
            fatalError("Esse modulo já registrou uma rota: ( \(route) )")
        }
        
        TQIRouter.routes[route] = routerDelegate
        debugPrint("[PBRouter] Rota registrada com sucesso: \(route)")
     }
    
    public static func coordinator(for location: RouterLocation) -> Coordinator? {
        return TQIRouter.routes[location.path]?.coordinator(for: location)
    }
    
    // Deprecated
    @available(*, deprecated, message: "CoordinatorManager Deprecated. Use PBRouter.register!")
    static var manager: CoordinatorManagerProtocol?
    
    @available(*, deprecated, message: "PBRouter configure Deprecated. Use PBRouter.register!")
    public static func configure(manager: CoordinatorManagerProtocol) {
        TQIRouter.manager = manager
    }
    
}

@available(*, deprecated, message: "RouterModuleStartProtocol startCoorinator Deprecated. Use PBRouter.register!")
public protocol RouterModuleStartProtocol {
     static func startCoorinator(_ module: ModuleDestination?) -> Coordinator
 }
