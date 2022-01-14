//
//  LoginAPI.swift
//  TQIBank
//
//  Created by Roberth Diorges on 12/01/22.
//

import Foundation
import VFNetwork

enum LoginAPI {
    case authenticate
}

extension LoginAPI: APIBuilder {
    
    var path: URLPath {
        switch self {
        case .authenticate:
            return .plain("auth")
        }
    }
    
    var httpMethod: HTTPMethods {
        switch self {
        case .authenticate:
            return .post
        }
    }
    
    var headers: HTTPHeader {
        .empty
    }
    
    var task: HTTPTask {
        switch self {
        case .authenticate:
            return .request
        }
    }
}

