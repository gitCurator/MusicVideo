//
//  ViewController.swift
//  MusicVideo
//
//  Created by cyLAB on 2016. 4. 1..
//  Copyright © 2016년 cyLAB. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var videos = [Videos]() // <--
    
    
    
    
    
    @IBOutlet var tableView: UITableView!

    @IBOutlet var displayLabel: UILabel!
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        //manual link
        // tableView.dataSource = self
        // tableView.delegate = self
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
        
        reachabilityStatusChanged()
        
        
        
        
        //call api
        
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=20/json", completion: didLoadData)

        
//||        // rather than passing into another func (didLoadData), done it self
//||        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json") {
//||            (result:String) in
//||            print(result)
//||        }
    
        
    }
    
    
    
    
    
    
//    func didLoadData(result:String) {   //callBack  + edit videos @part6
    
    func didLoadData(videos: [Videos]) {
        
        
        
        //part7
        print(reachabilityStatus)
        
        
        self.videos = videos //  <--
        
        for item in videos {
            print("name = \(item.vName)")
        }
        
        
        for (index, item) in videos.enumerate() { // <--
            print("\(index) name = \(item.vName)")
        }
        
        // indexing old fashion
        // 1.
        // for i in 0..<videos.count {
        //      let video = videos[i]
        //      print("\(i) name = \(video.vName)")
        //  }
        //
        // 2.
        // for var i = 0; i < videos.count; i++ {
        //      let video = videos[i]
        //      print("\(i) name = \(video.vName)")
        // }
        
        
        //TABLEVIEW
        
        tableView.reloadData()
        
        
        
        
        
    
//        print(result)
        
        
          //alert off @part6 and will build in UI
        
//        let alert = UIAlertController(title: (result), message: nil, preferredStyle: .Alert)
//        let okAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
//            //...
//        }
//        
//        alert.addAction(okAction)
//        self.presentViewController(alert, animated: true, completion: nil)
    
    }
    
    
    
    func reachabilityStatusChanged() {
        
        switch reachabilityStatus {
        case NOACCESS : view.backgroundColor = UIColor.redColor()
            displayLabel.text = "No Internet"
        case WIFI : view.backgroundColor = UIColor.greenColor()
            displayLabel.text = "Reachability with WIFI"
        case WWAN : view.backgroundColor = UIColor.yellowColor()
            displayLabel.text = "Reachability with Cellular"
        default:return
        }
        
    }
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChagned", object: nil)
    }
    
    
    
    
    // TABLEVIEW
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let video = videos[indexPath.row]
        cell.textLabel?.text = ("\(indexPath.row + 1)")
        cell.detailTextLabel?.text = video.vName
        
        return cell
    }
    


    
    
    
    
    
    
    
}









//  CACHE _off
//  to disable cache, add a line NSURLCache @AppDelegate.swift file  -->
//  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//    
//  -->>>  NSURLCache.setSharedURLCache(NSURLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil))
//    
//    return true
//}
