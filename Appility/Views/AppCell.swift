//
//  AppCell.swift
//  Appility
//
//  Created by Diego Salazar on 2/24/17.
//  Copyright © 2017 Diego Salazar. All rights reserved.
//

import UIKit

class AppCell: UICollectionViewCell {
        
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    
    override func prepareForReuse() {
        appIcon.image = nil
        appNameLabel.text = nil
    }
}
