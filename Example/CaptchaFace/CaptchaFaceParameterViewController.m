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
#import "CaptchaFaceViewController.h"

const double ANIMATION_LAPSTIME = 0.25;
const int NAVIGATIONBAR_PADDING = 44;

@interface CaptchaFaceParameterViewController ()

@property (assign, nonatomic) int minRandomValue;
@property (assign, nonatomic) int maxRandomValue;
@property (assign, nonatomic) CGRect offFrame;
@property (assign, nonatomic) CGRect onFrame;
@property (assign, nonatomic) CGRect smallTableViewFrame;
@property (assign, nonatomic) CGRect bigTableViewFrame;
@end

@implementation CaptchaFaceParameterViewController

#pragma mark - Life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.minRandomValue = self.maxRandomValue = -1;
    
    self.pickerData = [CaptchaFaceEvent faceEventsStrings];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismiss)];
    [self.view addGestureRecognizer:tap];
    
    if (!self.randomData)
    {
        self.randomData = [NSMutableArray arrayWithArray:@[@(self.minRandomValue), @(self.maxRandomValue)]];
    }
    if (!self.customData)
    {
        self.customData = [NSMutableArray arrayWithArray:@[]];
    }
    if (!self.datasource)
    {
        self.datasource = [NSMutableArray arrayWithArray:@[]];
    }
    int firstHeightOfTableView = self.tableView.bounds.size.height;
    self.offFrame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.pickerView.bounds.size.height);
    self.onFrame = CGRectMake(0, self.view.bounds.size.height - self.pickerView.bounds.size.height, self.view.bounds.size.width, self.pickerView.bounds.size.height);
    self.bigTableViewFrame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.view.frame.size.width, firstHeightOfTableView);
    self.smallTableViewFrame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.view.frame.size.width, firstHeightOfTableView - self.pickerView.frame.size.height - 44);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.eventButton.hidden = YES;
    self.eventLabel.hidden = YES;
    self.headerView.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.hidden = NO;
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.pickerView setFrame:self.offFrame];
    [self.tableView setFrame:self.bigTableViewFrame];
    if (self.segmentedControl.selected == 1 && self.editingTextField)
    {
        [self.editingTextField resignFirstResponder];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self hidePicker];
    
    if ([self.customData[self.customData.count - 1] isKindOfClass:NSNull.class])
    {
        if (self.editingTextField.text.length == 0)
        {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"oups", nil) message:NSLocalizedString(@"oups_no_value", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles: nil];
        [alert show];
        }
        self.editingTextField.text = NSLocalizedString(@"move_up", nil);
        self.customData[0] = self.pickerData[0];
        self.eventButton.userInteractionEnabled = NO;
        self.eventButton.tintColor = [UIColor grayColor];
        [self.editingTextField becomeFirstResponder];
        [self showPicker];
    }
    else
    {
        self.eventButton.userInteractionEnabled = YES;
        self.eventButton.tintColor = [UIColor captchaBlue];
    }
    self.pickerView.showsSelectionIndicator = YES;
    self.bottomConstraint.constant = 0;
}

- (void)hidePicker
{
    [UIView animateWithDuration:ANIMATION_LAPSTIME animations:^{
        [self.pickerView setFrame:self.offFrame];
        [self.tableView setFrame:self.bigTableViewFrame];
    }];
    
}

- (void)showPicker
{
    [UIView animateWithDuration:ANIMATION_LAPSTIME animations:^{
        [self.pickerView setFrame:self.onFrame];
        [self.tableView setFrame:self.smallTableViewFrame];
    }];
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
    [textField resignFirstResponder];
    
    self.datasource = [self getCurrentDatasource];
    
    if ([identifier isEqualToString:@"textCell"])
    {
        if (indexPath.row == 0)
        {
            labelOfCell.text = NSLocalizedString(@"min_event", nil);
            NSString *minString = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@", self.datasource[0]]];
            textField.text = ![self.datasource[0] isEqual: @(-1)] ? minString : nil;
        }
        else
        {
            labelOfCell.text = NSLocalizedString(@"max_event", nil);
            NSString *maxString = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@", self.datasource[1]]];
            textField.text = ![self.datasource[0] isEqual: @(-1)] ? maxString : nil;
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
        
        if (self.datasource.count > indexPath.row && [self.datasource[indexPath.row] isKindOfClass:NSString.class])
        {
            textField.text = nil;
            textField.text = self.datasource[indexPath.row];
        }
        else
        {
            textField.text = nil;
            textField.text = @"";
        }
    }
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.segmentedControl.selectedSegmentIndex == 1)
    {
        UITextField *textField = (UITextField *)[cell viewWithTag:2];
        [textField becomeFirstResponder];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (IBAction)reloadTableView:(id)sender
{
    [self.tableView reloadData];
    self.headerView.backgroundColor = [UIColor clearColor];
    self.eventButton.hidden = self.segmentedControl.selectedSegmentIndex == 0 ? YES : NO;
    self.eventLabel.hidden = self.segmentedControl.selectedSegmentIndex == 0 ? YES : NO;
    
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.segmentedControl.selectedSegmentIndex == 1)
    {
        if (editingStyle == UITableViewCellEditingStyleDelete)
        {
            //add code here for when you hit delete
            [self.customData removeObjectAtIndex:indexPath.row];
        }
        [self.tableView reloadData];
    }
}



#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.editingTextField = textField;
    if (!self.inputAccessoryView && self.segmentedControl.selectedSegmentIndex == 0)
    {
        self.inputAccessoryView = [self createInputAccessoryView];
    }
    
    // Now add the view as an input accessory view to the selected textfield.
    if (self.segmentedControl.selectedSegmentIndex == 0)
    {
        [textField setInputAccessoryView:self.inputAccessoryView];
        return YES;
    }
    else
    {
        //pop pickerView
        
        [self.pickerView selectRow:0 inComponent:0 animated:YES];
        [UIView animateWithDuration:ANIMATION_LAPSTIME animations:^{
            [self.pickerView setFrame:self.onFrame];
            [self.tableView setFrame:self.smallTableViewFrame];
        }];
        if (textField.text.length == 0)
        {
            textField.text = nil;
        }
        UIView* dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        textField.inputView = dummyView;
        return YES;
    }
}


-(UIView *)createInputAccessoryView
{
    // Create the input accessory view
    UIView *inputAccView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, self.view.bounds.size.width, 40.0)];
    
    [inputAccView setBackgroundColor:[UIColor captchaGray]];
    [inputAccView setAlpha: 0.7];
    
    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnDone setFrame:CGRectMake(self.view.bounds.size.width - 90, 0.0f, 80.0f, 40.0f)];
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

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell*)[[textField superview] superview]];
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    if (self.segmentedControl.selectedSegmentIndex == 0)
    {
        if (indexPath.row == 0)
        {
            if (textField.text.length > 0 && [textField.text intValue] != 0)
            {
                [self.randomData replaceObjectAtIndex:0 withObject:textField.text];
            }
            else
            {
                [self.randomData replaceObjectAtIndex:0 withObject:@(-1)];
            }
            self.minRandomValue = [textField.text intValue];
        }
        else if (indexPath.row == 1)
        {
            //alert user if minTime is greater than maxTime
            textField.inputAccessoryView = self.toolBar;
            
            self.maxRandomValue = [textField.text intValue];
            
            UIAlertView *alertNotValid = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"oups", nil) message:NSLocalizedString(@"oups_message", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles: nil];
            
            UIAlertView *alertNotHigher = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"oups", nil) message:NSLocalizedString(@"oups_higher_value", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles: nil];
            
            int textCastedInInt = [self.editingTextField.text intValue];
            
            BOOL textIsAnIntNotNull = textCastedInInt != 0;
            BOOL secondValueIsHigher = !(self.maxRandomValue && self.minRandomValue && self.maxRandomValue <= self.minRandomValue) || ([textField.text rangeOfCharacterFromSet:notDigits].location != NSNotFound);
            if (!textIsAnIntNotNull)
            {
                [alertNotValid show];
            }
            else if (!secondValueIsHigher)
            {
                [alertNotHigher show];
                self.editingTextField.text = @"";
            }
            else
            {
                if (textField.text.length > 0)
                {
                    [self.randomData replaceObjectAtIndex:1 withObject:textField.text];
                }
                else
                {
                    [self.randomData replaceObjectAtIndex:1 withObject:@(-1)];
                }
            }
        }
    }
    else
    {
        if (textField.text.length > 0)
        {
        [self.customData replaceObjectAtIndex:indexPath.row withObject:textField.text];
        }
        [self.editingTextField resignFirstResponder];
    }
    return YES;
}

- (void)showInvalidDataAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"oups", nil) message:NSLocalizedString(@"oups_message", nil) delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"ok", nil), nil];
    [alert show];
}

- (IBAction)didTouchTextField:(id)sender {
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
    [self.customData addObject: [NSNull null]];
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
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)[[self.editingTextField superview] superview]];
    [self.customData replaceObjectAtIndex:indexPath.row withObject:self.pickerData[row]];
    self.editingTextField.text = self.pickerData[row];
    [self.editingTextField resignFirstResponder];
}


#pragma mark - Navigation
- (IBAction)didTouchBackButton:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (BOOL)thereIsNoDataInRandomMode
{
    return self.segmentedControl.selectedSegmentIndex == 0 && (self.randomData.count == 0 || [self.randomData[0] isEqual: @(-1)] || [self.randomData[1] isEqual: @(-1)]);
}

- (BOOL)thereIsNoDataInCustomMode
{
    return self.segmentedControl.selectedSegmentIndex == 1 && self.customData.count == 0;
}

- (IBAction)randomDataDidChanged:(UITextField *)aTextField
{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)[[self.editingTextField superview] superview]];
    self.randomData[indexPath.row] = self.editingTextField.text;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setHidden:NO];
}
- (IBAction)didTouchOkButton:(id)sender
{
    //[self.editingTextField resignFirstResponder];
    if ([self thereIsNoDataInRandomMode] || [self thereIsNoDataInCustomMode] || ([[self.randomData lastObject] integerValue] <= [[self.randomData firstObject] integerValue] && self.segmentedControl.selectedSegmentIndex == 0))
    {
        [self showInvalidDataAlert];
    }
    else
    {
        NSArray *vcs = self.navigationController.viewControllers;
        CaptchaFaceSwiftViewController *previousVC = (CaptchaFaceSwiftViewController*)vcs[vcs.count-2];
        
        previousVC.settingsSaved = YES;
        previousVC.settingsMode = self.segmentedControl.selectedSegmentIndex;
        previousVC.randomSettings = self.randomData;
        previousVC.customSettings = self.customData;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
