//
//  App+CoreDataProperties.swift
//  Appility
//
//  Created by Diego Salazar on 2/26/17.
//  Copyright © 2017 Diego Salazar. All rights reserved.
//

import Foundation
import CoreData

extension App {
    
    @NSManaged var name: String?
    @NSManaged var summary: String?
    @NSManaged var artist: String?
    @NSManaged var category: String?
    @NSManaged var logo100: String?
    @NSManaged var logo53: String?
    @NSManaged var logo100Data: NSData?
    @NSManaged var price: NSNumber?
    @NSManaged var releaseDate: String?
    @NSManaged var rights: String?
    
}
