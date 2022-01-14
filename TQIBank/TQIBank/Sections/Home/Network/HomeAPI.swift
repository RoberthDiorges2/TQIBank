//
//  HomeAPI.swift
//  TQIBank
//
//  Created by Roberth Diorges on 13/01/22.
//

import VFNetwork

enum HomeAPI {
    case menus
}

extension HomeAPI: APIBuilder {
    
    var path: URLPath {
        switch self {
        case .menus:
            return .plain("menus/home")
        }
    }
    
    var httpMethod: HTTPMethods {
        switch self {
        case .menus:
            return .get
        }
    }
    
    var headers: HTTPHeader {
        .empty
    }
    
    var task: HTTPTask {
        switch self {
        case .menus:
            return .request
        }
    }
}
