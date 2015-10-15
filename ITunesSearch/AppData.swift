//
//  AppData.swift
//  ITunesSearch
//
//  Created by Chris Archibald on 10/14/15.
//  Copyright © 2015 Chris Archibald. All rights reserved.
//

import UIKit

class AppData: NSObject {
    
    var authorName: String
    var appName: String
    var imageURLString: String
    var jsonData: NSDictionary
    
    init(authorName: String, appName: String, imageURLString: String, jsonData: NSDictionary) {
        self.authorName = authorName
        self.appName = appName
        self.imageURLString = imageURLString
        self.jsonData = jsonData
        
        super.init()
    }
    
    override var description: String {
        return "\(self.authorName), \(self.appName), \(self.imageURLString)"
    }

}
