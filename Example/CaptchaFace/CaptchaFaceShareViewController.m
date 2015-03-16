//
//  CaptchaFaceShareViewController.m
//  CaptchaFace
//
//  Created by Dorothée DOUBLET on 03/02/2015.
//  Copyright (c) 2015 Peter Schaeffer. All rights reserved.
//

#import "CaptchaFaceShareViewController.h"

@interface CaptchaFaceShareViewController ()

@end

@implementation CaptchaFaceShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [super viewDidAppear:animated];
    if ([SLComposeViewController
         isAvailableForServiceType:SLServiceTypeTwitter]){
        SLComposeViewController *controller =
        [SLComposeViewController
         composeViewControllerForServiceType:SLServiceTypeTwitter];
        [controller setInitialText:@"MacBook Airs are amazingly thin!"];
        [controller addImage:[UIImage imageNamed:@"MacBookAir"]];
        [controller addURL:[NSURL URLWithString:@"http://www.apple.com/"]];
        controller.completionHandler = ^(SLComposeViewControllerResult result){
            NSLog(@"Completed");
        };
        [self presentViewController:controller animated:YES completion:nil];
    } else {
        NSLog(@"The twitter service is not available");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
