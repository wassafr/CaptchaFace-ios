//
//  CaptchaFaceViewController.h
//  CaptchaFace
//
//  Created by Peter Schaeffer on 12/17/2014.
//  Copyright (c) 2014 Wassa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
/**
 *  Objective-C sample use
 */

@interface CaptchaFaceViewController : UIViewController <UIAlertViewDelegate>

@property(nonatomic, strong) NSMutableArray *randomSettings;
@property(nonatomic, strong) NSMutableArray *customSettings;
@property (strong, nonatomic) IBOutlet UILabel *savedLabel;
@property (assign, nonatomic) BOOL settingsSaved;
@property (assign, nonatomic) BOOL settingsMode;
@property (assign, nonatomic) int score;

- (IBAction)didPressStartCaptcha:(id)sender;
@end
