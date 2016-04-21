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

//sec <---
import LocalAuthentication



class MusicVideoDetailVC: UIViewController {

    
    
    var videos:Videos!
    
    
    //sec <---
    var securitySwitch:Bool = false
    
    
    
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

    
    
    
    
    @IBAction func socialMedia(sender: UIBarButtonItem) {
        
        //sec: shareMeadia()
        securitySwitch = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        switch securitySwitch {
        case true:
            touchIdChk()
        default:
            shareMeadia()
        }
        
    }
    
    
    
    
    //sec <---
    func touchIdChk() {
        
        //create an alert
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "continue", style: UIAlertActionStyle.Cancel, handler: nil))
        
        //ceate the loacal authentication context
        let context = LAContext()
        var touchIDError : NSError?
        let reasonString = "Touch-Id authentication is needed to share info on Social Media"
        
        //check local device accessibility
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &touchIDError) {
            //check type of auth
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: {(success, policyError) -> Void in
                if success {
                    //successful
                    dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                        self.shareMeadia()
                    }
                } else {
                    alert.title = "Unsuccessful!"
                    switch LAError(rawValue: policyError!.code)! {
                    case .AppCancel:
                        alert.message = "Authentication was cancelled by app"
                    case .AuthenticationFailed:
                        alert.message = "Valid credential failed"
                    case .PasscodeNotSet:
                        alert.message = "Passcode is not set on this device"
                    case .SystemCancel:
                        alert.message = "Authentication was cancelled by the system"
                    case .TouchIDLockout:
                        alert.message = "Too many failed attempts"
                    case .UserCancel:
                        alert.message = "You cancelled the request"
                    case .UserFallback:
                        alert.message = "No passcode, TouchID"
                    default:
                        alert.message = "Unable to authenticate"
                    }
                    
                    //show the alert
                    dispatch_async(dispatch_get_main_queue()) {[unowned self] in
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                }
            })
        } else {
            //unable to access local dev auth
            //set the eoor title
            alert.title = "Error"
            
            // more info
            switch LAError(rawValue: touchIDError!.code)! {
            case .TouchIDNotEnrolled:
                alert.message = "Touch ID is not enrolled"
            case .TouchIDNotAvailable:
                alert.message = "Touch ID is not available on the device"
            case .PasscodeNotSet:
                alert.message = "Passcode has not been set"
            case .InvalidContext:
                alert.message = "The context is invalid"
            default:
                alert.message = "Local authentification is not available"
            }
            
            //show alert
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
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
