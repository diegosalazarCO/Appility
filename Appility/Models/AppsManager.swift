//
//  AppsManager.swift
//  Appility
//
//  Created by Diego Salazar on 2/18/17.
//  Copyright © 2017 Diego Salazar. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON
import UIKit

protocol AppsManagerDelegate {
    func didLoadApps()
}

class AppsManager {
    
    var applications = [App]()
    var categories: [String:[App]] = [:]
    var listOfCategories = [String]()
    var delegate: AppsManagerDelegate? = nil
    let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
    
    // MARK: - App Main Actions
    
    func loadApps() {
        let apiURL = "https://itunes.apple.com/us/rss/topfreeapplications/limit=100/json"
        let url = NSURL(string: apiURL)!
        let session = NSURLSession.sharedSession().dataTaskWithURL(url){
            (data, response, error) in
            
            guard let data = data else {
                print("Oops! something is wrong with the data..")
                return
            }
            
            let json = JSON(data: data)
            // Each Entry is an App in the JSON
            let entries = json["feed"]["entry"].array!
            
            self.clearData()
            for app in entries {
                let appName = app["im:name"]["label"].string!
                let appSummary = app["summary"]["label"].string!
                let appCategory = app["category"]["attributes"]["label"].string!
                let appLogo53 = app["im:image"][0]["label"].string!
                //let appLogo75 = app["im:image"][1]["label"].string!
                let appLogo100 = app["im:image"][2]["label"].string!
                let appArtist = app["im:artist"]["label"].string!
                let appPrice = app["im:price"]["attributes"]["amount"].string!
                let appReleaseDate = app["im:releaseDate"]["attributes"]["label"].string!
                let appRights = app["rights"]["label"].string!

                if let context = self.appDelegate?.managedObjectContext {
                    let app = NSEntityDescription.insertNewObjectForEntityForName("App", inManagedObjectContext: context) as! Appility.App
                    
                    app.name = appName
                    app.summary = appSummary
                    app.artist = appArtist
                    app.category = appCategory
                    app.logo100 = appLogo100
                    app.logo53 = appLogo53
                    app.releaseDate = appReleaseDate
                    app.rights = appRights
                    let doublePrice = Double(appPrice)
                    app.price = NSNumber(double: doublePrice!)
        
                    do {
                        try(context.save())
                    } catch let error {
                        print(error)
                    }
                }
            }
            self.loadData()
            // Sort categories alphabetically
            self.listOfCategories.sortInPlace { $0.localizedCaseInsensitiveCompare($1) == NSComparisonResult.OrderedAscending }
            if let delegate = self.delegate {
                dispatch_async(dispatch_get_main_queue(), { delegate.didLoadApps() })
            }
        }
        session.resume()
    }
    
    // Loading data from Core Data
    func loadData() {
        if let context = appDelegate?.managedObjectContext {
            let fetchRequest = NSFetchRequest(entityName: "App")
            do {
                applications = try(context.executeFetchRequest(fetchRequest)) as! [App]
                // Add new entry in dictionary ej: [Games : [Fifa, Angrybirds...]]
                for app in applications {
                    let category = app.category
                    if self.categories[category!] != nil { } else {
                        self.categories[category!] = []
                    }
                    self.categories[app.category!]?.append(app)
                    
                    // Just the list of Categories in array
                    if self.listOfCategories.contains(app.category!) { } else {
                        self.listOfCategories.append(app.category!)
                    }
                }
            } catch let error {
                print(error)
            }
        }
    }
    
    // Clear all the data in Core Data
    func clearData() {
        if let context = appDelegate?.managedObjectContext {
            do {
                let entityNames = ["App"]
                
                for entityName in entityNames {
                    let fetchRequest = NSFetchRequest(entityName: entityName)
                    let objects = try(context.executeFetchRequest(fetchRequest)) as? [NSManagedObject]
                    for object in objects! {
                        context.deleteObject(object)
                    }
                }
                try(context.save())
            } catch let error {
                print(error)
            }
        }
    }
}
