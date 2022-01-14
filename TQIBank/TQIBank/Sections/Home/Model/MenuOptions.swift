//
//  Options.swift
//  TQIBank
//
//  Created by Roberth Diorges on 13/01/22.
//

import VFNetwork

public struct MenuOptions: VCodable {
    public init() {
        menuOptions = []
    }
    
    public var menuOptions: [MenuOption] = []
}

public struct MenuOption: VCodable {
    public var id: String = ""
    public var optionName: String = ""
}
