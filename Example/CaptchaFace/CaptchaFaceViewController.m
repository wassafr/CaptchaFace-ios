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

@interface CaptchaFaceViewController ()

@end

@implementation CaptchaFaceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.randomSettings = [NSMutableArray arrayWithArray:@[]];
    self.customSettings = [NSMutableArray arrayWithArray:@[]];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.savedLabel.hidden = self.settingsSaved ? NO : YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)didPressStartCaptcha:(id)sender
//{
//    //first check if the device supports wtf
//    if([UIDevice supportsCapchaFace])
//    {
//        //Display the captchaFace viewcontroller
//        [self showCaptchaViewControllerWithLicenceKey:@"<your_key>" completion:^(NSError *error, int successCount, int totalCount) {
//        
//            //if no error, the capcha finished without technical error (but the user may have failed validation steps)
//            if(!error)
//            {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Captcha completed" message:[NSString stringWithFormat:@"%d / %d completed",successCount,totalCount] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [alert show];
//            }
//            //an error with the userCancelation domain is returned if the user cancels the captcha
//            else if([error.domain isEqualToString:@"userCancelation"])
//            {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Captcha canceled" message:@"you canceled the captcha" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [alert show];
//            }
//            else
//            {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Captcha not started" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [alert show];
//            }
//        }];
//    }
//}

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
                NSMutableArray *events = [self getEventsArrayWithSettings:self.customSettings];
                scenario = [CaptchaFaceScenario scenarioWithEvents:events intervalBetweenEvents:1.0 failureTimeInterval:5.0];
            }
        }
        else
        {
            scenario = nil;
        }
#warning changer la licence en <your_key>
        [self showCaptchaViewControllerWithLicenceKey:@"azertyuiop" scenario:scenario completion:^(NSError *error, int successCount, int totalCount)
         {
             
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

//- (NSMutableArray *)getEventsArrayWithSettings:(NSArray *)anArray
//{
//    NSMutableArray *eventsArray = [[NSMutableArray alloc] init];
//    
//    [anArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        CaptchaFaceEvent *event;
//        if ([obj isEqualToString:NSLocalizedString(@"move_up", nil)])
//        {
//            event = [CaptchaFaceEvent moveUp];
//        }
//        else if ([obj isEqualToString:NSLocalizedString(@"move_down", nil)])
//        {
//            event = [CaptchaFaceEvent moveDown];
//        }
//        else if ([obj isEqualToString:NSLocalizedString(@"move_left", nil)])
//        {
//            event = [CaptchaFaceEvent moveLeft];
//        }
//        else if ([obj isEqualToString:NSLocalizedString(@"move_right", nil)])
//        {
//            event = [CaptchaFaceEvent moveRight];
//        }
//        else if ([obj isEqualToString:NSLocalizedString(@"move_forward", nil)])
//        {
//            event = [CaptchaFaceEvent moveForward];
//        }
//        else if ([obj isEqualToString:NSLocalizedString(@"move_backward", nil)])
//        {
//            event = [CaptchaFaceEvent moveBackward];
//        }
//        else if ([obj isEqualToString:NSLocalizedString(@"smile", nil)])
//        {
//            event = [CaptchaFaceEvent smile];
//        }
//        else if ([obj isEqualToString:NSLocalizedString(@"smile", nil)])
//        {
//            event = [CaptchaFaceEvent yell];
//        }
//        eventsArray[idx]=event;
//    }];
//    return eventsArray;
//}

- (IBAction)didPressParameter:(id)sender
{
    [self performSegueWithIdentifier:@"showParameters" sender:self];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController* controller = [segue destinationViewController];
    if ([controller isKindOfClass:[CaptchaFaceParameterViewController class]])
    {
        CaptchaFaceParameterViewController* viewController = (CaptchaFaceParameterViewController *)controller;
        viewController.delegate = self;
        viewController.randomData = self.randomSettings;
        viewController.customData = self.customSettings;
    }
}


@end
