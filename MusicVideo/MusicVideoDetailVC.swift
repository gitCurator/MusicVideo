//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by cyLAB on 2016. 4. 18..
//  Copyright © 2016년 cyLAB. All rights reserved.
//

import UIKit

//play video
import AVKit
import AVFoundation




class MusicVideoDetailVC: UIViewController {

    
    
    var videos:Videos!
    
    
    @IBOutlet var vName: UILabel!
    
    @IBOutlet var videoImage: UIImageView!
    
    @IBOutlet var vGenre: UILabel!
    
    @IBOutlet var vPrice: UILabel!
   
    @IBOutlet var vRights: UILabel!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = videos.vArtist
        
        vName.text = videos.vName
        vPrice.text = videos.vPrice
        vRights.text = videos.vRights
        vGenre.text = videos.vGenre
        
        if videos.vImageData != nil {
            videoImage.image = UIImage(data: videos.vImageData!)
        } else {
            videoImage.image = UIImage(named: "imageNotAvailable")
        }
        
    }

    
    
    @IBAction func socialMedia(sender: AnyObject) {
        shareMeadia()
    }
    
    
    func shareMeadia () {
        
        let activity1 = "HavU seen this?"
        let activity2 =  ("(\(videos.vName) by \(videos.vArtist)")
        let activity3 = "WhatU think?"
        let activity4 = videos.vLinkToiTunes
        let activity5 = "Step it up!"
        
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [activity1, activity2, activity3, activity4, activity5], applicationActivities: nil)

        //exclude times in the array with commas
        //activityViewController.excludedActivityTypes = [UIActivityTypeMail]
        
        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error) in
            if activity == UIActivityTypeMail {
                print ("email selected")
            }
        }
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    
    
    
    
    
    @IBAction func playVideo(sender: UIBarButtonItem) {
        
        let url = NSURL(string: videos.vVideoUrl)!
        let player = AVPlayer(URL: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.presentViewController(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
        
    }
    
    
    
    
}
