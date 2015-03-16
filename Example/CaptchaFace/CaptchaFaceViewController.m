//
//  CaptchaFaceViewController.m
//  CaptchaFace
//
//  Created by Peter Schaeffer on 12/17/2014.
//  Copyright (c) 2014 Peter Schaeffer. All rights reserved.
//

#import "CaptchaFaceViewController.h"
#import "CaptchaFace/UIViewController+CaptchaFace.h"
#import "CaptchaFaceParameterViewController.h"
#import "CaptchaFace-Swift.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface CaptchaFaceViewController ()

@end

@implementation CaptchaFaceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.randomSettings = [NSMutableArray arrayWithArray:@[@(-1), @(-1)]];
    self.customSettings = [NSMutableArray arrayWithArray:@[]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.savedLabel.hidden = self.settingsSaved ? NO : YES;
    self.navigationController.navigationBar.hidden = YES;
    if (self.settingsSaved)
    {
        self.savedLabel.transform = CGAffineTransformScale(self.savedLabel.transform, 0.35, 0.35);
        [UIView animateWithDuration:0.75 animations:^{
            self.savedLabel.transform = CGAffineTransformScale(self.savedLabel.transform, 6, 6);
            [UIView animateWithDuration:1.0 animations:^{
                self.savedLabel.transform = CGAffineTransformScale(self.savedLabel.transform, 0.5, 0.5);
            }];
        }];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)didPressStartCaptcha:(id)sender
{
    //first check if the device supports wtf
    if([UIDevice supportsCapchaFace])
    {
        //Display the captchaFace viewcontroller
        //if random mode selected
        CaptchaFaceScenario *scenario;
        if (self.settingsSaved)
        {
            
            if (self.settingsMode == 0)
            {
                NSRange eventsRange= {[[self.randomSettings firstObject] intValue], [[self.randomSettings lastObject] intValue] - [[self.randomSettings firstObject] intValue]};
                scenario = [CaptchaFaceScenario scenarioWithRandomEvents:eventsRange  intervalBetweenEvents:1.0 failureTimeInterval:5.0];
            }
            else
            {
                NSArray *events = [CaptchaFaceEvent faceEvents:self.customSettings];
                scenario = [CaptchaFaceScenario scenarioWithEvents:events intervalBetweenEvents:1.0 failureTimeInterval:5.0];
            }
        }
        else
        {
            scenario = nil;
        }
        //WARNING: replace <your_key> by real one ( available on captchaface.com )
        [self showCaptchaViewControllerWithLicenceKey:@"<your_key>" scenario:scenario completion:^(NSError *error, int successCount, int totalCount)
         {
             //if no error, the capcha finished without technical error (but the user may have failed validation steps)
             if(!error)
             {
                 [self displayScoreAlertWithSuccessCount:successCount totalCount:totalCount];
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

- (IBAction)didPressParameter:(id)sender
{
    [self performSegueWithIdentifier:@"showParameters" sender:self];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[self.navigationController setNavigationBarHidden:NO animated:animated];
    //self.settingsSaved = NO;
}

#pragma mark - Scores

- (void)displayScoreAlertWithSuccessCount:(int)successCount totalCount:(int)totalCount
{
    self.score = successCount*100;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Captcha completed" message:[NSString stringWithFormat:@"%d / %d completed. You've scored %d points !",successCount, totalCount, self.score] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:NSLocalizedString(@"share", nil), nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        // Share your score here...
    NSString *shareText=[NSString stringWithFormat:NSLocalizedString(@"score", nil), self.score];
    
    UIImage *shareImage = [[UIImage alloc] init];
    shareImage=[UIImage imageNamed:@"round_icon"];
    
    NSURL *shareUrl = [NSURL URLWithString:NSLocalizedString(@"url", nil)];
    
    NSArray *activityItems = [NSArray arrayWithObjects:shareText, shareImage, shareUrl, nil];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    
    NSArray *excluded=@[UIActivityTypeMessage, UIActivityTypePostToWeibo,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        excluded = [excluded arrayByAddingObjectsFromArray:@[UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop]];
    }
    
    
    activityViewController.excludedActivityTypes=excluded;
    
    
    [self presentViewController:activityViewController animated:YES completion:nil];
        }
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController* controller = [segue destinationViewController];
    if ([controller isKindOfClass:[CaptchaFaceParameterViewController class]])
    {
        CaptchaFaceParameterViewController* viewController = (CaptchaFaceParameterViewController *)controller;
        viewController.randomData = self.randomSettings;
        viewController.customData = self.customSettings;
    }
}


@end
