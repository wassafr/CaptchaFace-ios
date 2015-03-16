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

class CaptchaFaceSwiftViewController: UIViewController
{
    
    @IBOutlet weak var savedLabel: UILabel!
    
    var settingsSaved:Bool = false
    var randomSettings:NSMutableArray?
    var customSettings :NSMutableArray?
    var settingsMode:Bool = false
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        // Here you can init your properties
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.savedLabel.hidden = !self.settingsSaved
        self.navigationController?.navigationBar.hidden = true;
    }

       
    @IBAction func didPressStartCaptcha(sender: AnyObject) {
        
        if UIDevice.supportsCapchaFace()
        {
            var scenario : CaptchaFaceScenario!
            let settingsAreSaved = settingsSaved
            if settingsAreSaved
            {
                let randomMode = settingsMode
                
                if randomMode != true
                {
                    if let actualRandomSettings = self.randomSettings
                    {
                        
                        let minTiming = actualRandomSettings[0].integerValue as Int
                        let maxTiming = actualRandomSettings[1].integerValue as Int
                        if (maxTiming > minTiming)
                        {
                            var eventsRange = NSMakeRange(minTiming, maxTiming - minTiming)
                            scenario = CaptchaFaceScenario(randomEvents: eventsRange, intervalBetweenEvents: 1.0, failureTimeInterval: 5.0)
                        }
                    }
                }
                else
                {
                    var pickerData = [CaptchaFaceEvent.faceEventsStrings()];
                    if let actualCustomSettings = self.customSettings
                    {
                        var selectedEvents = CaptchaFaceEvent.faceEvents(actualCustomSettings)
                        scenario = CaptchaFaceScenario(events: selectedEvents, intervalBetweenEvents: 1.0, failureTimeInterval: 5.0)
                    }
                }
            }
            else
            {
                scenario = nil
            }
                // WARNING: replace <your_key> by real one ( available on captchaface.com )
                self.showCaptchaViewControllerWithLicenceKey("<your_key>", scenario: scenario, completion:   { (error:NSError!,successCount:Int32, totalCount:Int32) -> Void in
                
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
            self.settingsSaved = false;
            let vc = segue.destinationViewController as CaptchaFaceParameterViewController;
            
            
            if let random = self.randomSettings
            {
                vc.randomData = NSMutableArray(array: random)
                
            }
            if let custom = self.customSettings
            {
                vc.customData = NSMutableArray(array: custom)
            }
            
        }
    }
}
