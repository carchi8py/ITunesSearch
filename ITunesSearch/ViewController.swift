//
//  ViewController.swift
//  ITunesSearch
//
//  Created by Chris Archibald on 10/13/15.
//  Copyright © 2015 Chris Archibald. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var appDataArray = [AppData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var searchTerm = "Paul Solt"
        if let escapedSearchTerm = searchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {
            var searchString = "https://itunes.apple.com/search?term=\(escapedSearchTerm)&entity=software"
            print(searchString)
            
            if let url = NSURL(string: searchString) {
                let task  = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {
                    data, response, error in
                    
                    if error != nil {
                        print("Error \(error?.localizedDescription)")
                    } else {
                        //print("data: \(data)")
                        
                        do {
                            let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                            print("\(jsonData)")
                            if let resultsArray = jsonData["results"] as? NSArray {
                                var appDataArray = [AppData]()
                                
                                // interate over the array
                                for item in resultsArray {
                                    if let artworkURLString = item["artworkUrl60"] as? String {
                                        print("artwork: \(artworkURLString)")
                                        
                                        if let artistName = item["artistName"] as? String {
                                            print("artist: \(artistName)")
                                            
                                            if let appName = item["trackCensoredName"] as? String {
                                                print("appName \(appName)")
                                                
                                                let appData = AppData(authorName: artistName, appName: appName, imageURLString: artworkURLString)
                                                
                                                appDataArray.append(appData)
                                            }
                                        }
                                    }
                                }
                                
                                dispatch_async(dispatch_get_main_queue(), {
                                    self.appDataArray = appDataArray
                                    print("app data is complete")
                                    print("\(self.appDataArray)")
                                })
                            }
                        } catch {
                            print("There was an error")
                        }
                    }
                    
                })
                task.resume()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

