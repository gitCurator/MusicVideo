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
