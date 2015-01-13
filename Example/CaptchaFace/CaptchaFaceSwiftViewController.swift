//
//  CaptchaFaceSwiftViewController.swift
//  CaptchaFace
//
//  Created by Peter Schaeffer on 18/12/2014.
//  Copyright (c) 2014 Wassa. All rights reserved.
//

import UIKit

/**
*  Swift sample use
*/
//

class CaptchaFaceSwiftViewController: UIViewController, SettingsProtocol
{
    
    @IBOutlet var subview: UIView!
    @IBOutlet var savedLabel: UILabel!
    
    var settingsSave:Bool
    var randomSettings: Array<NSInteger>
    var customSettings : Array<String>
    var settingsMode:Bool
    
    required init(coder aDecoder: NSCoder)
    {
        settingsSave = false
        settingsMode = false
        self.randomSettings = []
        self.customSettings = []
        super.init(coder: aDecoder)
    }
    
//    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
//      
//        settingsSave = false
//        settingsMode = false
//        self.randomSettings = []
//        self.customSettings = []
//        super.init(nibName: nil, bundle: nil)
//    }
    
//    convenience override init() {
//        self.init(nibName: nil, bundle: nil)
//    }
    
    
    func setRandomSettings(randomSettings: NSMutableArray!) {
        //self.randomSettings = randomSettings
    }
    func setCustomSettings(customSettings: NSMutableArray!) {
        //self.customSettings = customSettings
    }
    func setSettingsSaved(savedOrNot: Bool) {
        //self.settingsSaved = savedOrNot
    }
    func setSettingsMode(randomOrNot: Bool) {
        //self.settingsMode = randomOrNot
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        //self.savedLabel.hidden = self.settingsSaved;
    }
    
    //    @IBAction func didPressStartCaptcha(sender: AnyObject) {
    //
    //        if UIDevice.supportsCapchaFace()
    //        {
    //
    //            self.showCaptchaViewControllerWithLicenceKey("azertyuiop", completion: { (error:NSError!,successCount:Int32, totalCount:Int32) -> Void in
    //
    //                if let realError = error{
    //                    if realError.domain == "userCancelation"{
    //
    //                        let alertView = UIAlertView(title: "Captcha Canceled", message: "You canceled the captcha", delegate: nil, cancelButtonTitle: "OK")
    //                        alertView.show();
    //                    }
    //                    else {
    //                        let alertView = UIAlertView(title: "Captcha not started", message: realError.localizedDescription, delegate: nil, cancelButtonTitle: "OK")
    //                        alertView.show();
    //                    }
    //                }
    //                else {
    //
    //                    let message = "\(successCount) / \(totalCount) completed"
    //
    //                    let alertView = UIAlertView(title: "Captcha completed", message:message , delegate: nil, cancelButtonTitle: "OK")
    //                    alertView.show();
    //                }
    //
    //            })
    //        }
    //
    //    }
    
    @IBAction func didPressStartCaptcha(sender: AnyObject) {
        
        if UIDevice.supportsCapchaFace()
        {
            var scenario : CaptchaFaceScenario!
            let settingsAreSaved = settingsSave
            if settingsAreSaved
            {
                let randomMode = settingsMode
                
                if randomMode  == true
                {
                    let minTiming = self.randomSettings[0]
                    let maxTiming = self.randomSettings[1]
                    var eventsRange = NSMakeRange(minTiming, maxTiming)

                    
                    scenario = CaptchaFaceScenario(randomEvents: eventsRange, intervalBetweenEvents: 1.0, failureTimeInterval: 5.0)
                    
                }
                else
                {
                    var pickerData = [CaptchaFaceEvent .faceEventsStrings()];
                    
                    let listOfEvents = CaptchaFaceEvent.faceEventsStrings()
                    var selectedEvents = CaptchaFaceEvent.faceEvents(listOfEvents)
                    scenario = CaptchaFaceScenario(events: selectedEvents, intervalBetweenEvents: 1.0, failureTimeInterval: 5.0)
                }
            }
            else
            {
                    scenario = nil
            }
            self.showCaptchaViewControllerWithLicenceKey("azertyuiop", completion: { (error:NSError!,successCount:Int32, totalCount:Int32) -> Void in
                
                if let realError = error{
                    if realError.domain == "userCancelation"{
                        
                        let alertView = UIAlertView(title: "Captcha Canceled", message: "You canceled the captcha", delegate: nil, cancelButtonTitle: "OK")
                        alertView.show();
                    }
                    else {
                        let alertView = UIAlertView(title: "Captcha not started", message: realError.localizedDescription, delegate: nil, cancelButtonTitle: "OK")
                        alertView.show();
                    }
                }
                else {
                    
                    let message = "\(successCount) / \(totalCount) completed"
                    
                    let alertView = UIAlertView(title: "Captcha completed", message:message , delegate: nil, cancelButtonTitle: "OK")
                    alertView.show();
                }
                
            })
        }
    }
    
    @IBAction func didPressParameter(sender: AnyObject)
    {
        self.performSegueWithIdentifier("showParameters", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if (segue.identifier == "showParameters")
        {
            // pass data to next view
            let vc = segue.destinationViewController as CaptchaFaceParameterViewController;
            vc.delegate = self
            vc.randomData = NSMutableArray(array: self.randomSettings)
            vc.customData = NSMutableArray(array: self.customSettings)
        }
    }
}
