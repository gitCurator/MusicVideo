//
//  ViewController.swift
//  MusicVideo
//
//  Created by cyLAB on 2016. 4. 1..
//  Copyright © 2016년 cyLAB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var videos = [Videos]() // <--
    

    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        //call api
        
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)

        
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
}









//  CACHE _off
//  to disable cache, add a line NSURLCache @AppDelegate.swift file  -->
//  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//    
//  -->>>  NSURLCache.setSharedURLCache(NSURLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil))
//    
//    return true
//}
