//
//  APIManager.swift
//  MusicVideo
//
//  Created by cyLAB on 2016. 4. 1..
//  Copyright © 2016년 cyLAB. All rights reserved.
//

import Foundation

class APIManager {
    
    
    func loadData(urlString:String, completion: (result:String) -> Void) {
        
        
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
                dispatch_async(dispatch_get_main_queue()) {
                    completion(result: (error!.localizedDescription))
                }
                
            } else {
                // JSONSerialization
                //print(data)
                do {
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                        as? [String: AnyObject] { // dictionary {}
                        
                        print(json)
                        
                        let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                        dispatch_async(dispatch_get_global_queue(priority, 0)) {
                            dispatch_async(dispatch_get_main_queue()) {
                                completion(result: "JSONSerialization Successful")
                            }
                        }
                    }
                } catch {
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(result: "error in JSONSerialization")
                    }
                }   //end of JSONSerialization 
            }
        }   //task
        task.resume()
        
        
        

    }   //loadData
}   //APIManager