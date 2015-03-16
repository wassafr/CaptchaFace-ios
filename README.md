# CaptchaFace

[![Version](https://img.shields.io/cocoapods/v/CaptchaFace.svg?style=flat)](http://cocoadocs.org/docsets/CaptchaFace)
[![License](https://img.shields.io/cocoapods/l/CaptchaFace.svg?style=flat)](http://cocoadocs.org/docsets/CaptchaFace)
[![Platform](https://img.shields.io/cocoapods/p/CaptchaFace.svg?style=flat)](http://cocoadocs.org/docsets/CaptchaFace)

CaptchaFace is a tool that allows you to know if a mobile user is really human by identification of several visual steps through the camera.

## Installation

### Cocoapods

[CocoaPods](http://www.cocoapods.org) is the recommended way to add CaptchaFace to your project.

1. Add a pod entry for CaptchaFace to your *Podfile* :
 pod "CaptchaFace"
2. Install the pod(s) by running `pod install`.
3. Include CaptchaFace wherever you need it with `#import <CaptchaFace/UIViewController+CaptchaFace.h>` from Objective-C.

### Manual installation

1. Download the [latest code version](https://github.com/wassafr/CaptchaFace-ios/archive/master.zip) or add the repository as a git submodule to your git-tracked project.
2. Drag and drop the **Pod** directory from the archive in your project navigator. Make sure to select *Copy items* when asked if you extracted the code archive outside of your project.
3. Download the [opencv library](http://sourceforge.net/projects/opencvlibrary/files/opencv-ios/2.4.10/opencv2.framework.zip/download) and drag and drop the opencv2.framework in your project navigator.
4. Add the opencv dependancies in your project properties in *Build Phases* > *Link with libraries* :
    * libstdc++
    * Accelerate
    * AssetsLibrary
    * AVFoundation
    * CoreGraphics
    * CoreImage
    * CoreMedia
    * CoreVideo
    * Foundation
    * QuartzCore
    * UIKit
5. Include CaptchaFace wherever you need it with `#import <CaptchaFace/UIViewController+CaptchaFace.h>` from Objective-C or `import CaptchaFace` from Swift.



## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first. With [CocoaPods](http://www.cocoapods.org) , you can run `pod try CaptchaFace`
from the command line.

Make sure you also see [CaptchaFace documentation on Cocoadocs](http://cocoadocs.org/docsets/CaptchaFace).

**Attention :** To use the SDK, you need a API key that you can get on the [CaptchaFace website](http://captchaface.com)

###Basics
1. Add the following import to the top of the file or the bringing header for swift:

    ```objc
    #import <CaptchaFace/UIViewController+CaptchaFace.h>
    ```

2. Check if the user can run CaptchaFace using :

  ```objc
      // Objective-C
      [UIDevice supportsCapchaFace]
      ```
      ```swift
      // Swift
      UIDevice.supportsCapchaFace()
  ```

3. Show the captcha viewController with default parameters ( have to be called from any application's ViewController )

   ```objc
   // Objective-C
   [self showCaptchaViewControllerWithLicenceKey:@"<your_key>" completion:^(NSError *error, int successCount, int totalCount) {
   
   //Handle success and failure, see CaptchaFaceViewController.m in the Sample project for examples
   }];
   ```
   
   ```swift
   // Swift
  self.showCaptchaViewControllerWithLicenceKey("<your_key>", completion:   { (error:NSError!,successCount:Int32, totalCount:Int32) -> Void in
   //Handle success and failure, see CaptchaFaceSwiftViewController.swift  in the Sample project for examples
  
   })
  
   ```

### Advanced
If you want to personalize the event shown during the captchaFaceSession, you have to create a *CaptchaFaceScenario* object. This object can be created with random events in a range with the method : 

1. Create a CaptchaFaceScenario :
    * with random number of events within a range that you can define and custom timings
    
    ```objc
    // Objective-C
    
    NSRange eventsRange= {3,2};
    
    //3 to 5 random events will be played
    CaptchaFaceScenario *scenario = [CaptchaFaceScenario scenarioWithRandomEvents:eventsRange  intervalBetweenEvents:1.0 failureTimeInterval:5.0];
    ```
    ```swift
    // Swift
    
    let eventsRange = NSMakeRange(3, 2)
    
    //3 to 5 random events will be played
    let scenario = CaptchaFaceScenario(randomEvents: eventsRange, intervalBetweenEvents: 1.0, failureTimeInterval: 5.0)    
    ```
    * with Fixed events by creating an array of *CaptchaFaceEvent* 
    
    ```objc
    // Objective-C

        NSArray *events = @[[CaptchaFaceEvent smile],[CaptchaFaceEvent moveBackward],[CaptchaFaceEvent moveForward]];
        
        CaptchaFaceScenario *scenario = [CaptchaFaceScenario scenarioWithEvents:events intervalBetweenEvents:1.0 failureTimeInterval:5.0];
```
```swift
    // Swift
    let events = [CaptchaFaceEvent.smile(),CaptchaFaceEvent.moveBackward(),CaptchaFaceEvent.moveForward()]
    
    let scenario = CaptchaFaceScenario(events: events, intervalBetweenEvents: 1.0, failureTimeInterval: 5.0)
```

2. Show the captcha viewController with the created scenario : 

 ```objc
  // Objective-C
  [self showCaptchaViewControllerWithLicenceKey:@"<your_key>" scenario: scenario completion:^(NSError *error, int successCount, int totalCount) {
  
  //Handle success and failure, see CaptchaFaceViewController.m in the Sample project for examples
  }];
  ```
  
  ```swift
  // Swift
 self.showCaptchaViewControllerWithLicenceKey("<your_key>", scenario: scenario completion:   { (error:NSError!,successCount:Int32, totalCount:Int32) -> Void in
  //Handle success and failure, see CaptchaFaceSwiftViewController.swift  in the Sample project for examples
 
  })
 
  ```
 
## Requirements

* Xcode 5
* iOS 7
* ARC
* Devices responding to [UIDevice supportsCapchaFace], typically iPhones from iphone 4 and iPads from iPad 2

## Author

Wassa, contact@wassa.fr

