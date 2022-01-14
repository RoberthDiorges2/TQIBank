//
//  HomeService.swift
//  TQIBank
//
//  Created by Roberth Diorges on 13/01/22.
//

import VFNetwork

class HomeService: RequestService<HomeAPI> {
    
    func getMenus(completion: @escaping (Result<MenuOptions, Error>) -> Void) {
        execute(.menus, responseType: MenuOptions.self, completion: completion)
    }
}
