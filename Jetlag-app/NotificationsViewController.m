//
//  NotificationsViewController.m
//  Jetlag-app
//
//  Created by Matthias Vermeulen on 26/01/15.
//  Copyright (c) 2015 Noizy. All rights reserved.
//

#import "NotificationsViewController.h"
#import "DateCalc.h"
#import "NotificationManager.h"
#import "MainViewController.h"

#define kDatePickerSection 0
#define kDatePickerIndex 1
#define kreminderDatePickerSection 1
#define kreminderDatePickerIndex 2
#define kDatePickerCellHeight 164




@interface NotificationsViewController ()
{
    NotificationManager *notifManager;

}

@property (strong, nonatomic) IBOutlet UIDatePicker *wakeUpTimeDatePicker;
@property (strong, nonatomic) IBOutlet UITableViewCell *datePickerCell;
@property (strong, nonatomic) IBOutlet UILabel *wakeUpTimeLabel;
@property (strong, nonatomic) IBOutlet UITableViewCell *setReminderTimeCell;
@property (strong, nonatomic) IBOutlet UILabel *reminderLabel;
@property (strong, nonatomic) IBOutlet UILabel *remindMeCellTextLabel;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) IBOutlet UIDatePicker *reminderMinutesDatePicker;
@property (strong, nonatomic) IBOutlet UITableViewCell *reminderDatePickerCell;
@property  BOOL datePickerIsShowing;
@property BOOL reminderDatePickerIsShowing;
@property BOOL isReminderToStopEating;

@end



@implementation NotificationsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    notifManager = [[NotificationManager alloc]init];

    
    self.wakeUpTimeDatePicker.hidden = YES;
    self.reminderMinutesDatePicker.hidden = YES;
    self.datePickerIsShowing = NO;
    self.reminderDatePickerIsShowing = NO;
    self.reminderMinutesDatePicker.datePickerMode = UIDatePickerModeTime;
    self.wakeUpTimeDatePicker.datePickerMode = UIDatePickerModeTime;
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [ self.dateFormatter setDateFormat:@"HH:mm"];
    
    
    self.isReminderToStopEating = true;
    
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = self.tableView.rowHeight;
    
    if (indexPath.row == kDatePickerIndex & indexPath.section == 0){
        
        height = self.datePickerIsShowing ? kDatePickerCellHeight : 0.0f;
        
    }
    else if (indexPath.row == kreminderDatePickerIndex & indexPath.section == 1)
    {
        height = self.reminderDatePickerIsShowing ? kDatePickerCellHeight : 0.0f;
    }
    
    
    return height;
}




- (IBAction)saveNotifications:(UIBarButtonItem *)sender
{
    if (self.isReminderToStopEating)
    {
        DateCalc *timeObject = [[DateCalc alloc]init];
        NSDate *notificationDate = [NSDate dateWithTimeInterval:-57600 sinceDate:self.wakeUpTimeDatePicker.date]; //[timeObject calculateTimeToStopEating:self.wakeUpTimeDatePicker.date];
        NSDictionary *eatAlarmDict = @{@"firedate":notificationDate, @"alertBody":@"You have to stop eating now.", @"alertAction":@"",@"soundname":UILocalNotificationDefaultSoundName, @"notificationName":@"alarm" };

        [notifManager createNotification:eatAlarmDict];
        
        NSLog(@"Dit is het tijdstip dat gekozen is: %@", notificationDate);
        NSLog(@"Dit is de datepicker tijd: %@", self.wakeUpTimeDatePicker.date);
    }
    else
    {
        NSLog(@"nope");
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TimeChanged" object:self.wakeUpTimeLabel.text  userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TimeToStopEatingChanged" object:self.wakeUpTimeLabel.text  userInfo:nil];
    
    [self performSegueWithIdentifier:@"unwindChangeScreen" sender:self];
}


- (IBAction)setAlarmTime:(UIDatePicker *)sender
{
    self.wakeUpTimeLabel.text = [self.dateFormatter stringFromDate:sender.date]; //alarmtijd naar notification sturen
    NSLog(@"Tijd is veranderd!");
   

    
    [self passTimeBackToMainViewController:self.wakeUpTimeLabel.text]; //delegate method
    
    
}

- (void)passTimeBackToMainViewController:(NSString *)time
{
  
    
    if ([_delegate respondsToSelector:@selector(setAlarmTimeFromSettings:)])
    {
        NSLog(@"Delegate werkt");
        [_delegate setAlarmTimeFromSettings:time];
    }

}
- (IBAction)setStartOfFastNotification:(UISwitch *)sender
{
    if (sender.on)
    {
        self.isReminderToStopEating = true;
    }
    else
    {
        self.isReminderToStopEating = false;
    }
    
}

- (IBAction)setEatReminderNotification:(UISwitch *)sender
{
    if (!sender.on)
    {
        self.setReminderTimeCell.selectionStyle = UITableViewCellSelectionStyleGray;
        self.setReminderTimeCell.userInteractionEnabled = NO;
        self.reminderLabel.textColor = [UIColor grayColor];
        self.remindMeCellTextLabel.textColor = [UIColor grayColor];
    }
    else
    {
        self.setReminderTimeCell.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.setReminderTimeCell.userInteractionEnabled = YES;
        self.reminderLabel.textColor = [UIColor blueColor];
        self.remindMeCellTextLabel.textColor = [UIColor blueColor];
    }

}

- (void)showDatePickerCell
{
    
    self.datePickerIsShowing = YES;
    
    [self.tableView beginUpdates];
    
    [self.tableView endUpdates];
    
    self.wakeUpTimeDatePicker.hidden = NO;
    self.wakeUpTimeDatePicker.alpha = 0.0f;
    NSLog(@"Tiet");
    [UIView animateWithDuration:0.25 animations:^{
        
        self.wakeUpTimeDatePicker.alpha = 1.0f;
        
    }];
}

- (void)hideDatePickerCell
{
    
    self.datePickerIsShowing = NO;
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.wakeUpTimeDatePicker.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         self.wakeUpTimeDatePicker.hidden = YES;
                     }];
}

- (void)showReminderDatePickerCell
{
    
    self.reminderDatePickerIsShowing = YES;
    
    [self.tableView beginUpdates];
    
    [self.tableView endUpdates];
    
    self.reminderMinutesDatePicker.hidden = NO;
    self.reminderMinutesDatePicker.alpha = 0.0f;
    NSLog(@"Tiet");
    [UIView animateWithDuration:0.25 animations:^{
        
        self.reminderMinutesDatePicker.alpha = 1.0f;
        
    }];
    
}


- (void)hideReminderDatePickerCell
{
 
    self.reminderDatePickerIsShowing  = NO;
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.reminderMinutesDatePicker.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         self.reminderMinutesDatePicker.hidden = YES;
                     }];

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%i", (long)indexPath.row);
    
    if (indexPath.row == 0 & indexPath.section == 0){
        
        if (self.datePickerIsShowing){
            
            [self hideDatePickerCell];
            
        }else {

            [self showDatePickerCell];
        }
    }
    else if (indexPath.row == 1 & indexPath.section == 1)
    {
        if (self.reminderDatePickerIsShowing)
        {
            [self hideReminderDatePickerCell];
        }
        else
        {
            [self showReminderDatePickerCell];
        }
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}



// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
