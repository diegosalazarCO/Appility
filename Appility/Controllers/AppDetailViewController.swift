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
    @IBOutlet weak var sellerLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var app: App?
    var appImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let app = app {
            self.title = app.name
            if let appImage = appImage {
                    appIcon.image = appImage
                    appIcon.layer.cornerRadius = 27.0
                    appIcon.clipsToBounds = true
            }
            appNameLabel.text = app.name
            appArtistLabel.text = app.artist
            appDescriptionText.text = app.summary
            sellerLabel.text = app.rights
            categoryLabel.text = app.category
            releaseDateLabel.text = app.releaseDate
            let formatter = NSNumberFormatter()
            formatter.locale = NSLocale(localeIdentifier: "en_US")
            formatter.numberStyle = .CurrencyStyle
            var priceText = formatter.stringFromNumber(app.price!)
            if priceText == "$0.00" { priceText = "Free" }
            appPriceLabel.text = priceText
            priceLabel.text = priceText
        }
    }
    
    override func viewDidLayoutSubviews() {
        self.appDescriptionText.setContentOffset(CGPointZero, animated: false)
    }

}
