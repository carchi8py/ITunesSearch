//
//  ViewController.swift
//  ITunesSearch
//
//  Created by Chris Archibald on 10/13/15.
//  Copyright © 2015 Chris Archibald. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var appDataArray = [AppData]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var searchTerm = "Games"
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
                                    if let item = item as? NSDictionary {
                                        if let artworkURLString = item["artworkUrl60"] as? String {
                                            print("artwork: \(artworkURLString)")
                                        
                                            if let artistName = item["artistName"] as? String {
                                                print("artist: \(artistName)")
                                            
                                                if let appName = item["trackCensoredName"] as? String {
                                                    print("appName \(appName)")
                                                
                                                    let appData = AppData(authorName: artistName, appName: appName, imageURLString: artworkURLString, jsonData: item)
                                                
                                                    appDataArray.append(appData)
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                dispatch_async(dispatch_get_main_queue(), {
                                    self.appDataArray = appDataArray
                                    print("app data is complete")
                                    print("\(self.appDataArray)")
                                    
                                    self.tableView.reloadData()
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
    
    //Tableview DataSourceDelegate Methods
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        var appData = appDataArray[indexPath.row]
        
        cell.textLabel?.text = appData.appName
        cell.detailTextLabel?.text = appData.authorName
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return appDataArray.count
    }


}

