//
//  NavigationViewController.swift
//  Appility
//
//  Created by Diego Salazar on 2/27/17.
//  Copyright © 2017 Diego Salazar. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.barStyle = UIBarStyle.Black
        self.navigationBar.barTintColor = UIColor.appEmerald
        self.navigationBar.tintColor = UIColor.whiteColor()
    }

}
