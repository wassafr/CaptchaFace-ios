//
//  CaptchaFaceParameterViewController.h
//  CaptchaFace
//
//  Created by Dorothée DOUBLET on 07/01/2015.
//  Copyright (c) 2015 Peter Schaeffer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaptchaFaceViewController.h"

@interface CaptchaFaceParameterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) UITextField *minTextField;
@property (strong, nonatomic) UITextField *maxTextField;
@property (strong, nonatomic) UITextField *editingTextField;
@property (strong, nonatomic) UIView *inputAccessoryView;
@property (strong, nonatomic) NSMutableArray *datasource;
@property (strong, nonatomic) NSArray *pickerData;
@property (strong, nonatomic) NSMutableArray *randomData;
@property (strong, nonatomic) NSMutableArray *customData;
@property (nonatomic, weak) id<SettingsProtocol> delegate;

@property (strong, nonatomic) IBOutlet UIButton *eventButton;
@property (strong, nonatomic) IBOutlet UILabel *eventLabel;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;


@end
