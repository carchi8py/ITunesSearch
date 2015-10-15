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
    
    init(authorName: String, appName: String, imageURLString: String) {
        self.authorName = authorName
        self.appName = appName
        self.imageURLString = imageURLString
        
        super.init()
    }

}
