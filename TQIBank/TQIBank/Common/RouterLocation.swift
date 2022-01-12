//
//  RouterLocation.swift
//  TQIBank
//
//  Created by Roberth Diorges on 12/01/22.
//

import Foundation

public protocol RouterLocationDelegate: AnyObject {
    func onSuccess(_ result: Data?, localtion: RouterLocation)
    func onError(_ error: TQIRouterError, localtion: RouterLocation)
}

public extension RouterLocationDelegate {
    func onSuccess(_ result: Data?, localtion: RouterLocation) {}
    func onError(_ error: TQIRouterError, localtion: RouterLocation) {}
}

public class RouterLocation {
    
    public let path: String
    public let arguments: [String: String]?
    public let payload: Data?
    private weak var delegate: RouterLocationDelegate?
    
    public init(path: String, arguments: [String: String]? = nil, payload: Data? = nil, delegate: RouterLocationDelegate? = nil) {
        self.path = path
        self.arguments = arguments
        self.payload = payload
        self.delegate = delegate
    }
    
    public func onSuccess(_ result: Data?) {
        delegate?.onSuccess(result, localtion: self)
    }
    
    public func onError(_ error: TQIRouterError) {
        delegate?.onError(error, localtion: self)
    }

}
