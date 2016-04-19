//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by cyLAB on 2016. 4. 11..
//  Copyright © 2016년 cyLAB. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {

    var videos = [Videos]() // <--
    
    
    
    
    
    //@IBOutlet var tableView: UITableView!
    
    // @IBOutlet var displayLabel: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //manual link
        // tableView.dataSource = self
        // tableView.delegate = self
        
        
        /* error: use of string literal for objc selectors is deprecated; use #selector
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChange", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        */
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MusicVideoTVC.reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MusicVideoTVC.preferredFontChange), name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        
        
        
        reachabilityStatusChanged()  //will run only once part13
        
        
            //call api
        
            // part13 cut
            //
            //        let api = APIManager()
            //        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=20/json", completion: didLoadData)
        
        
                //||        // rather than passing into another func (didLoadData), done it self
                //||        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json") {
                //||            (result:String) in 
                //||            print(result)
                //||        }
        
    }
  
    
    
    func preferredFontChange() {
        print("preferredFontChange")
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
        case NOACCESS : // part14 off: view.backgroundColor = UIColor.redColor()
            
            //part 13 view controllers on detached view controllers is discouragged
            //move back to main queue
        
            dispatch_async(dispatch_get_main_queue()) {
        
        
                let alert = UIAlertController(title: "No Internet Access", message: "Please connect", preferredStyle: .Alert)
            
                let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
                    action -> () in
                    print("Cancel")
                }
            
                let deleteAction = UIAlertAction(title: "Delete", style: .Destructive) {
                    action -> () in
                    print("delete")
                }
            
                let okAction = UIAlertAction(title: "OK", style: .Default) {
                    action -> Void in
                    print("Ok")
                }
            
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                alert.addAction(deleteAction)
            
                self.presentViewController(alert, animated: true, completion: nil)
            
            }
            
        default:
            // part14 off: view.backgroundColor = UIColor.greenColor()
            if videos.count > 0 {
                print("Do not refresh API")
            } else {
                runAPI()
 
            }
            
/*
        // displayLabel.text = "No Internet"
        case WIFI : view.backgroundColor = UIColor.greenColor()
        // displayLabel.text = "Reachability with WIFI"
        case WWAN : view.backgroundColor = UIColor.yellowColor()
        // displayLabel.text = "Reachability with Cellular"
        default:return
 
*/
        }
        
    }
    
    
     //part 13 PASTE
    func runAPI() {
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=200/json", completion: didLoadData)
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChagned", object: nil)
    }

    
    
    
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos.count
    }

    
    //part14: reuse 'cell'
    private struct storyboard {
        static let cellReuseIdentifier = "cell"
        //for segwa
        static let segueIdentifier = "musicDetail"
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) <-- reuseCell
        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cellReuseIdentifier, forIndexPath: indexPath) as! MusicVideoTableViewCell
        //let cell is now a custom cell of MusicVideoTableViewCell, so cast it as..
        
        
        
        // Configure the cell...
        
        //part14: no longer needed
        
        //let video = videos[indexPath.row]
        cell.video = videos[indexPath.row]
        
        
        //cell.textLabel?.text = ("\(indexPath.row + 1)")
        //cell.detailTextLabel?.text = video.vName
        
        
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == storyboard.segueIdentifier {
            if let indexpath = tableView.indexPathForSelectedRow {
                let video = videos[indexpath.row]
                let dvc = segue.destinationViewController as! MusicVideoDetailVC
                dvc.videos = video
                
            }
        }
        
    }

}
