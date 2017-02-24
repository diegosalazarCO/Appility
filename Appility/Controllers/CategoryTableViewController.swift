//
//  CategoryTableViewController.swift
//  Appility
//
//  Created by Diego Salazar on 2/22/17.
//  Copyright © 2017 Diego Salazar. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController, AppsManagerDelegate {
    
    
    // MARK: - AppsManager Delegate 
    
    let appManager = AppsManager()
    
    func didLoadApps() {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appManager.delegate = self
        appManager.loadApps()
    }
    

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appManager.categories.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath) as! CategoryTableViewCell
        cell.categoryLabel.text = appManager.listOfCategories[indexPath.row]

        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
