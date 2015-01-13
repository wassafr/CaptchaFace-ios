//
//  CaptchaFaceParameterViewController.m
//  CaptchaFace
//
//  Created by Dorothée DOUBLET on 07/01/2015.
//  Copyright (c) 2015 Peter Schaeffer. All rights reserved.
//

#import "CaptchaFaceParameterViewController.h"
#import "CaptchaFaceEvent.h"
#import "CaptchaFace-Swift.h"

@interface CaptchaFaceParameterViewController ()

@property (assign, nonatomic) int minRandomValue;
@property (assign, nonatomic) int maxRandomValue;
@property (assign, nonatomic) BOOL okButtonPressed;
@property (assign, nonatomic) CGRect offFrame;
@property (assign, nonatomic) CGRect onFrame;
@property (assign, nonatomic) int animationLapsTime;
@property (assign, nonatomic) int navigationBarPadding;
@end

@implementation CaptchaFaceParameterViewController

#pragma mark - Life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.minRandomValue = self.maxRandomValue = 0;
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:255 green:151 blue:43 alpha:1];
    
    
    self.pickerData = [CaptchaFaceEvent faceEventsStrings];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismiss)];
    
    [self.view addGestureRecognizer:tap];
    
    if (!self.randomData)
    {
    self.randomData = [NSMutableArray array];
    }
    if (!self.customData)
    {
    self.customData = [NSMutableArray arrayWithArray:@[]];
    }
    if (!self.datasource)
    {
    self.datasource = [NSMutableArray arrayWithArray:@[]];
    }
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.navigationBarPadding = 64;
    self.animationLapsTime = 0.25;
    self.offFrame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.pickerView.bounds.size.height);
    self.onFrame = CGRectMake(0, self.view.bounds.size.height - self.navigationBarPadding - self.pickerView.bounds.size.height, self.view.bounds.size.width, self.pickerView.bounds.size.height);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.okButtonPressed = NO;
    self.eventButton.hidden = YES;
    self.eventLabel.hidden = YES;
    self.headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //self.bottomConstraint.constant = -self.pickerView.bounds.size.height;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.delegate setSettingsSaved:self.okButtonPressed];
    [self.delegate setSettingsMode:self.segmentedControl.selectedSegmentIndex];
}

#pragma mark - Keyboard or Picker

-(void)doneWithNumberPad
{
    if ([self.minTextField isFirstResponder])
    {
        [self.minTextField resignFirstResponder];
    }
}

-(void)dismiss
{
    [self.editingTextField resignFirstResponder];
    [UIView animateWithDuration:self.animationLapsTime animations:^{
        [self.pickerView setFrame:self.offFrame];
    }];
    
    self.pickerView.showsSelectionIndicator = YES;
    self.bottomConstraint.constant = 0;
}

#pragma mark - TableView

- (NSMutableArray *)getCurrentDatasource
{
    return self.segmentedControl.selectedSegmentIndex == 0 ? self.randomData : self.customData;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.segmentedControl.selectedSegmentIndex == 0)
    {
        return 2;
    }
    else
    {
        return [[self getCurrentDatasource] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier;
    
    if (self.segmentedControl.selectedSegmentIndex == 0)
    {
        identifier = @"textCell";
    }
    else
    {
        identifier = @"textFieldCell";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    UILabel *labelOfCell =  (UILabel *)[cell viewWithTag:1];
    UITextField *textField = (UITextField *)[cell viewWithTag:2];
    
    self.datasource = [self getCurrentDatasource];
    
    if ([identifier isEqualToString:@"textCell"])
    {
        if (indexPath.row == 0)
        {
            labelOfCell.text = NSLocalizedString(@"min_event", nil);
            textField.text = self.datasource.count > 0 ? self.datasource[0]: nil;
        }
        else
        {
            labelOfCell.text = NSLocalizedString(@"max_event", nil);
            textField.text = self.datasource.count >1 ? self.datasource[1] : nil;
        }
    }
    else if ([identifier isEqualToString:@"buttonCell"])
    {
        labelOfCell.text = NSLocalizedString(@"event", nil);
    }
    else
    {
        [cell setEditing:YES animated:YES];
        
        UITextField *textField = (UITextField *)[cell viewWithTag:2];

        if (self.datasource.count > indexPath.row)
        {
            labelOfCell.text = NSLocalizedString(@"choose_event", nil);
            if ([self.datasource[indexPath.row] isKindOfClass:NSString.class])
            {
                textField.text = self.datasource[indexPath.row];
            }
            else
            {
                textField.text = nil;
            }
            textField.placeholder = NSLocalizedString(@"choose_event", nil);
        }
    }
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    
    return cell;
}

- (IBAction)reloadTableView:(id)sender
{
    [self.tableView reloadData];
    self.headerView.backgroundColor = self.segmentedControl.selectedSegmentIndex == 0 ? [UIColor groupTableViewBackgroundColor] : [UIColor whiteColor];
    self.eventButton.hidden = self.segmentedControl.selectedSegmentIndex == 0 ? YES : NO;
    self.eventLabel.hidden = self.segmentedControl.selectedSegmentIndex == 0 ? YES : NO;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        [self.customData removeObjectAtIndex:indexPath.row];
    }
    [self.tableView reloadData];
}



#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (!self.inputAccessoryView && self.segmentedControl.selectedSegmentIndex == 0)
    {
        self.inputAccessoryView = [self createInputAccessoryView];
    }
 
    self.editingTextField = textField;
    
    // Now add the view as an input accessory view to the selected textfield.
    if (self.segmentedControl.selectedSegmentIndex == 0)
    {
        [textField setInputAccessoryView:self.inputAccessoryView];
        return YES;
    }
    else
    {
        //pop pickerView
        [UIView animateWithDuration:self.animationLapsTime animations:^{
            [self.pickerView setFrame:self.onFrame];
        }];
        return NO;
    }
}

-(UIView *)createInputAccessoryView
{
    // Create the view that will play the part of the input accessory view.
    // Note that the frame width (third value in the CGRectMake method)
    // should change accordingly in landscape orientation. But we don’t care
    // about that now.
    UIView *inputAccView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, self.view.bounds.size.width, 40.0)];
    
    // Set the view’s background color. We’ ll set it here to gray. Use any color you want.
    [inputAccView setBackgroundColor:[UIColor lightGrayColor]];
    
    // We can play a little with transparency as well using the Alpha property. Normally
    // you can leave it unchanged.
    [inputAccView setAlpha: 0.8];
    
    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnDone setFrame:CGRectMake(240.0, 0.0f, 80.0f, 40.0f)];
    [btnDone setTitle:@"Done" forState:UIControlStateNormal];
    [btnDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(doneTyping) forControlEvents:UIControlEventTouchUpInside];
    
    // Now that our buttons are ready we just have to add them to our view.
    [inputAccView addSubview:btnDone];
    
    return inputAccView;
}


- (void)doneTyping
{
    [self.editingTextField resignFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell*)[[textField superview] superview]];
    
    if (self.segmentedControl.selectedSegmentIndex == 0)
    {
        if (indexPath.row == 0)
        {
            self.randomData = [NSMutableArray arrayWithArray:@[textField.text]];
            self.minRandomValue = [textField.text intValue];
        }
        else if (indexPath.row == 1)
        {
            //alert user if minTime is greater than maxTime
            textField.inputAccessoryView = self.toolBar;
            
            self.maxRandomValue = [textField.text intValue];
            if (self.maxRandomValue && self.minRandomValue && self.maxRandomValue <= self.minRandomValue)
            {
                [self showInvalidDataAlert];
                self.editingTextField.text = nil;
            }
            else
            {
                [self.randomData addObject:textField.text];
            }
        }
    }
    else
    {
        [self.customData addObject:textField.text];
        
    }
}

- (void)showInvalidDataAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"oups", nil) message:NSLocalizedString(@"oups_message", nil) delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"ok", nil), nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // the user clicked OK
    [self.editingTextField becomeFirstResponder];
}

#pragma mark - Buttons
- (IBAction)addAnEvent:(UIButton *)aButton
{
    //add a row
    [self.customData addObject:[NSNull null]];
    
    aButton.userInteractionEnabled = NO;
    aButton.tintColor = [UIColor lightGrayColor];
    [self.tableView reloadData];
}

#pragma mark - PickerView
// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return (int)self.pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickerData[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.editingTextField.text = self.pickerData[row];
    [self.editingTextField resignFirstResponder];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)[[self.editingTextField superview] superview]];
    
    [self.customData replaceObjectAtIndex:indexPath.row withObject:self.pickerData[row]];
    [self.customData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (![obj isKindOfClass:NSNull.class])
        {
            self.eventButton.userInteractionEnabled = YES;
            self.eventButton.tintColor = [UIColor CaptchaColor:939598 alpha:1];
        }
    }];
}

#pragma mark - Navigation
- (IBAction)didTouchBackButton:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)didTouchOkButton:(id)sender
{
    self.okButtonPressed = YES;
    [self.delegate setRandomSettings:self.randomData];
    [self.delegate setCustomSettings:self.customData];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
