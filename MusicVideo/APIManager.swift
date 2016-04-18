//
//  APIManager.swift
//  MusicVideo
//
//  Created by cyLAB on 2016. 4. 1..
//  Copyright © 2016년 cyLAB. All rights reserved.
//

import Foundation

class APIManager {
    
    
    func loadData(urlString:String, completion: [Videos] -> Void) { //completion: (result:String) off to Videos: part6
        
        
        // urlString: passing url @controller - url of itune's api. api.loadData(%)
        // result: input parameter to another func
        
        
        //  CACHE _off
        //  to disable cache, add a line NSURLCache @AppDelegate.swift file  -->
        //  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //
        //  -->>>  NSURLCache.setSharedURLCache(NSURLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil))
        //    
        //    return true
        //  }
        //
        // OR ephemeralSessionConfiguration within APIManager
        // OR cache on: use sharedSession
        //let session = NSURLSession.sharedSession()  //singleton, cache_on
        
        
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let url = NSURL(string: urlString)!
        
        
//        let task = session.dataTaskWithURL(url) {  //suspended unless with task.resume
//            (data, response, error) -> Void in
//            
//            dispatch_async(dispatch_get_main_queue()) {  //moving background to main thread
//                if error != nil {
//                    completion(result: (error!.localizedDescription))
//                } else {
//                    completion(result: "NSURLSession sucessful")
//                    print(data)
//                }
//            }
//        }
//        task.resume()



        let task = session.dataTaskWithURL(url) {
            (data, response, error) -> Void in
            
            if error != nil {
                
                // off fr part6: just print the error
                //
                //  dispatch_async(dispatch_get_main_queue()) {
                //    completion(result: (error!.localizedDescription))
                //  }
                
                print(error!.localizedDescription)
                
                
            } else {
                // JSONSerialization
                //print(data)
                do {
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                        //as? [String: AnyObject] { // dictionary {}
                        // as? [JSONDictionary] {  //Part4 typealias //edit part6 to follow json str down flow
                        as? JSONDictionary,
        
                        // print(json) off @Part6
                        feed = json["feed"] as? JSONDictionary,
                        entries = feed["entry"] as? JSONArray {
                        
                            var videos = [Videos]()
                        
                            // part 14 indexing +1: 
                            // for entry in entries {
                            for (index, entry) in entries.enumerate() {
                            
                                //error! : (data: entry as? JSONDictionary)  <--- ??
                                // will loop all @MusicVideo.swift file
                                let entry = Videos(data: (entry as? JSONDictionary)!)
                                
                                entry.vRank = index + 1 //  <--indexing part14
                                
                                videos.append(entry)
                            }
                        
                            let i = videos.count
                            print("iTunesApiManager - total count --> \(i)")
                            print(" ")
                        
                        
                        
                        
                            let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                                dispatch_async(dispatch_get_main_queue()) {
                                    // completion(result: "JSONSerialization Successful") @part6
                                    completion(videos) // --> pass it to func loadData: completion: [Videos]
                                }
                            }
                        
                        
                        
                    }
                } catch { 
                    // dispatch_async(dispatch_get_main_queue()) {
                    //    completion(result: "error in JSONSerialization")
                    // }
                    
                    print("error in NSJSONSerialization")
                    
                    
                }   //end of JSONSerialization 
            }
        }   //task
        task.resume()
        
        
        

    }   //loadData
}   //APIManager