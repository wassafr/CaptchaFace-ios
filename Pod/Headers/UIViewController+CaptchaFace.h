//
//  UIViewController+WTFCaptcha.h
//  CaptchaFace
//
//  Created by Peter Schaeffer on 01/12/2014.
//  Copyright (c) 2014 Wassa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaptchaFaceScenario.h"

@interface UIViewController (CaptchaFace)
/**
 *  Displays modaly a CaptchaFace ViewController with default parameters
 *
 *  @param licenceKey Parameter required to launch CapchaFace SDK
 *  @param completion Allows to retrieve results, if the viewController fails to launch the error Domain and localizedDescription explains the issue
 */
- (void)showCaptchaViewControllerWithLicenceKey:(NSString*)licenceKey completion:(void(^)(NSError *error,int successCount, int totalCount))completion;
/**
 *  Displays modaly a CaptchaFace ViewController playing the provided scenario
 *
 *  @param licenceKey licenceKey Parameter required to launch CapchaFace SDK
 *  @param scenario   the scenario to play when the CaptchaFace SDK is launched
 *  @param completion completion Allows to retrieve results, if the viewController fails to launch the error Domain and localizedDescription explains the issue
 */
- (void)showCaptchaViewControllerWithLicenceKey:(NSString*)licenceKey scenario:(CaptchaFaceScenario*)scenario completion:(void(^)(NSError *error,int successCount, int totalCount))completion;
@end


@interface UIDevice (CaptchaFace)
/**
 *  Check if the device is powerfull enought to launch capta face, you should lauch this method before trying to launch CapchaFace
 *
 *  @return YES if capchaFace can run on the device
 */
+ (BOOL)supportsCapchaFace;
@end

