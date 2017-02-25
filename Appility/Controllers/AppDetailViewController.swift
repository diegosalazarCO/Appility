//
//  AppDetailViewController.swift
//  Appility
//
//  Created by Diego Salazar on 2/25/17.
//  Copyright © 2017 Diego Salazar. All rights reserved.
//

import UIKit

class AppDetailViewController: UIViewController {

    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var appArtistLabel: UILabel!
    @IBOutlet weak var appPriceLabel: UILabel!
    @IBOutlet weak var appDescriptionText: UITextView!
    
    var app: App?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let app = app {
            //appIcon.image = app.logo100
            appNameLabel.text = app.name
            appArtistLabel.text = app.artist
            appDescriptionText.text = app.summary
        }
    }

}
