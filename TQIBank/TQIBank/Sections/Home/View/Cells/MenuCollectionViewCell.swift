//
//  MenuCollectionViewCell.swift
//  TQIBank
//
//  Created by Roberth Diorges on 13/01/22.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var menuNameLabel: UILabel!
    
    public func setup(option: MenuOption) {
        menuNameLabel.text = option.name
    }
}
