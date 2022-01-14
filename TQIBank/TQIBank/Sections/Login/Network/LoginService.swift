//
//  LoginService.swift
//  TQIBank
//
//  Created by Roberth Diorges on 12/01/22.
//

import VFNetwork

class LoginService: RequestService<LoginAPI> {
    
    func postAuthenticate(userName: String, password: String,
                            completion: @escaping (Result<User, Error>) -> Void) {
        execute(.authenticate, responseType: User.self, completion: completion)
    }
}
