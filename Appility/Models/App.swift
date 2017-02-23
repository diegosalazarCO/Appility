//
//  App.swift
//  Appility
//
//  Created by Diego Salazar on 2/18/17.
//  Copyright © 2017 Diego Salazar. All rights reserved.
//

import Foundation

class App {
    
    let name: String
    let summary: String
    let category: String
    let logo53: String
    let logo75: String
    let logo100: String
    let artist: String
    
    init(name: String, summary: String, category: String, logo53: String, logo75: String, logo100: String, artist: String) {
        self.name = name
        self.summary = summary
        self.category = category
        self.logo53 = logo53
        self.logo75 = logo75
        self.logo100 = logo100
        self.artist = artist
    }
}
