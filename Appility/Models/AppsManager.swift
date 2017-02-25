//
//  AppsManager.swift
//  Appility
//
//  Created by Diego Salazar on 2/18/17.
//  Copyright © 2017 Diego Salazar. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol AppsManagerDelegate {
    func didLoadApps()
}

class AppsManager {
    
    var applications = [App]()
    var categories: [String:[App]] = [:]
    var listOfCategories = [String]()
    var delegate: AppsManagerDelegate? = nil
    
    func loadApps() {
        let apiURL = "https://itunes.apple.com/us/rss/topfreeapplications/limit=20/json"
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
            for app in entries {
                let appName = app["im:name"]["label"].string!
                //print(appName)
                let appSummary = app["summary"]["label"].string!
                //print(appSummary)
                let appCategory = app["category"]["attributes"]["label"].string!
                //print(appCategory)
                let appLogo53 = app["im:image"][0]["label"].string!
                //print(appLogo53)
                let appLogo75 = app["im:image"][1]["label"].string!
                let appLogo100 = app["im:image"][2]["label"].string!
                let appArtist = app["im:artist"]["label"].string!
                
                let application = App(name: appName,
                                      summary: appSummary,
                                      category: appCategory,
                                      logo53: appLogo53,
                                      logo75: appLogo75,
                                      logo100: appLogo100,
                                      artist: appArtist)
                // Add aplication to Aplications Array
                self.applications.append(application)
                // Add new entry in dictionary ej: [Games : [Fifa, Angrybirds...]]
                if self.categories[application.category] != nil { } else {
                    self.categories[application.category] = []
                }
                self.categories[application.category]?.append(application)
                // Just the list of Categoriues in array
                if self.listOfCategories.contains(application.category) { } else {
                    self.listOfCategories.append(application.category)
                }
            }
            // Sort categories alphabetically
            self.listOfCategories.sortInPlace { $0.localizedCaseInsensitiveCompare($1) == NSComparisonResult.OrderedAscending }
            if let delegate = self.delegate {
                dispatch_async(dispatch_get_main_queue(), { delegate.didLoadApps() })
            }
        }
        session.resume()
    }
}
