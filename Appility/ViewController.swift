//
//  ViewController.swift
//  Appility
//
//  Created by Diego Salazar on 2/18/17.
//  Copyright © 2017 Diego Salazar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let appManager = AppsManager()
        appManager.loadApps()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

