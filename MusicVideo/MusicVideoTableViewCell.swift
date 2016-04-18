//
//  MusicVideoTableViewCell.swift
//  MusicVideo
//
//  Created by cyLAB on 2016. 4. 17..
//  Copyright © 2016년 cyLAB. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {


    var video: Videos? {
        didSet {
            updateCell()
        }
    }
    
    
    
    @IBOutlet var musicImage: UIImageView!
    
    @IBOutlet var rank: UILabel!
    
    @IBOutlet var musicTitle: UILabel!
    
    
    
    func updateCell() {
        
        
        //font cus
        musicTitle.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        rank.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        
        
        musicTitle.text = video?.vName
        rank.text = ("\(video!.vRank)")
        // musicImage.image = UIImage(named: "imageNotAvailable")
        
        
        if video!.vImageData != nil {
            print("Get data from array ...")
            musicImage.image = UIImage(data: video!.vImageData!)
        } else {
            GetVideoImage(video!, imageView: musicImage)
            print("Get images in background thread")
        }
        
        
        
        
    }
    
    
    
    func GetVideoImage(video: Videos, imageView : UIImageView) {
        
        
        //run background
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            let data = NSData(contentsOfURL: NSURL(string: video.vImageUrl)!)
            
            var image : UIImage?
            if data != nil {
                video.vImageData = data
                image = UIImage(data: data!)
            }
            
            //mv back to main q
            dispatch_async(dispatch_get_main_queue()) {
                imageView.image = image
            }
            
        }
    }
    
    
    
    
}
