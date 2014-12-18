//
//  CaptchaFaceViewController.m
//  CaptchaFace
//
//  Created by Peter Schaeffer on 12/17/2014.
//  Copyright (c) 2014 Peter Schaeffer. All rights reserved.
//

#import "CaptchaFaceViewController.h"
#import "CaptchaFace/UIViewController+CaptchaFace.h"
@interface CaptchaFaceViewController ()

@end

@implementation CaptchaFaceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didPressStartCaptcha:(id)sender
{
    //first check if the device supports wtf
    if([UIDevice supportsCapchaFace])
    {
        //Display the captchaFace viewcontroller
        [self showCaptchaViewControllerWithLicenceKey:@"<your_key>" completion:^(NSError *error, int successCount, int totalCount) {
            
            //if no error, the capcha finished without technical error (but the user may have failed validation steps)
            if(!error)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Captcha completed" message:[NSString stringWithFormat:@"%d / %d completed",successCount,totalCount] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            //an error with the userCancelation domain is returned if the user cancels the captcha
            else if([error.domain isEqualToString:@"userCancelation"])
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Captcha canceled" message:@"you canceled the captcha" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Captcha not started" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }];
    }
}
@end
