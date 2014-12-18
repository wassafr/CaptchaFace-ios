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
class CaptchaFaceSwiftViewController: UIViewController {

    @IBAction func didPressStartCaptcha(sender: AnyObject) {
        
        if UIDevice.supportsCapchaFace()
        {
            
            self.showCaptchaViewControllerWithLicenceKey("<your_key>", completion: { (error:NSError!,successCount:Int32, totalCount:Int32) -> Void in
                
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
}
