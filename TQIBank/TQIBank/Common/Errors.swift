//
//  Errors.swift
//  TQIBank
//
//  Created by Roberth Diorges on 12/01/22.
//

import Foundation

public enum TQIRouterError: Error {
    case module(Error)
    case start(Error)
}

public enum CoordinatorError: Error {
    case notFound
}

