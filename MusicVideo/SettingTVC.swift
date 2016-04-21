//
//  SettingTVC.swift
//  MusicVideo
//
//  Created by cyLAB on 2016. 4. 19..
//  Copyright © 2016년 cyLAB. All rights reserved.
//

import UIKit

//feedback: MessageUI + MFMailComposeViewControllerDelegate
import MessageUI



class SettingTVC: UITableViewController, MFMailComposeViewControllerDelegate {

    
    
    @IBOutlet var aboutDisplay: UILabel!
    
    
    @IBOutlet var feedBackDisplay: UILabel!
    
    
    @IBOutlet var securityDisplay: UILabel!
     
    
    @IBOutlet var touchID: UISwitch!
    
    
    @IBOutlet var bestImageDisplay: UILabel!
    
    
    @IBOutlet var APICnt: UILabel!
    
    
    @IBOutlet var sliderCnt: UISlider!
    
    
    
    
    @IBOutlet var numberAPICnt: UILabel!
    
    @IBOutlet var dragDisplay: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MusicVideoTVC.preferredFontChange), name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        
        //setting: scroll off
        tableView.alwaysBounceVertical = false
        
        
        //title heading @setting page
        title = "Settings"
        
        
        //touchid user stor
        touchID.on = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("APICNT") != nil) {
            
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("APICNT") as! Int
            APICnt.text = "\(theValue)"
            sliderCnt.value = Float(theValue)
        } else {
            sliderCnt.value = 10.0
            APICnt.text = ("\(Int(sliderCnt.value))")
        }

    }
    
    
    
    
    
    @IBAction func valueChanged(sender: AnyObject) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(Int(sliderCnt.value), forKey: "APICNT") //value:float 2 int
        APICnt.text = ("\(Int(sliderCnt.value))")
        
    }
    
    
    @IBAction func touchIdSec(sender: UISwitch) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if touchID.on {
            defaults.setBool(touchID.on, forKey: "SecSetting")
        } else {
            defaults.setBool(false, forKey: "SecSetting")
        }
    }
    
    
    
    
    
    // for an instant reflect on setting's change
    func preferredFontChange() {
        
        aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        feedBackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bestImageDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        APICnt.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        numberAPICnt.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        dragDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)

    }
    
    
    
    //feedback row 1, due to no data source exit, use the row path
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0 && indexPath.row == 1 {
            let mailComposeViewController = configureMail()
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                //no email acc
                mailAlert()
            }
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            
        }
    }
    
    func configureMail() -> MFMailComposeViewController {
    
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["cylab@me.com"])
        mailComposeVC.setSubject("MVA feedback")
        mailComposeVC.setMessageBody("Hi, sharing feedback...", isHTML: false)
        return mailComposeVC
    }
    
    func mailAlert() {
        let alertController: UIAlertController = UIAlertController(title: "Alert", message: "No email acc", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default) {
            action -> Void in
            // ...
        }
        
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("Mail cancelled")
        case MFMailComposeResultSaved.rawValue:
            print("Mail saved")
        case MFMailComposeResultSent.rawValue:
            print("Mail sent")
        case MFMailComposeResultFailed.rawValue:
            print("Mail failed")
        default:
            print("Unknown issue")
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }


    
}
