//
//  NotificationsViewController.m
//  Jetlag-app
//
//  Created by Matthias Vermeulen on 26/01/15.
//  Copyright (c) 2015 Noizy. All rights reserved.
//

#import "NotificationsViewController.h"
#import "DateCalc.h"

#define kDatePickerSection 0
#define kDatePickerIndex 1
#define kreminderDatePickerSection 1
#define kreminderDatePickerIndex 2
#define kDatePickerCellHeight 164


@interface NotificationsViewController ()
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

//http://masteringios.com/blog/2013/11/18/ios-7-in-line-uidatepicker-part-2/2/

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.wakeUpTimeDatePicker.hidden = YES;
    self.reminderMinutesDatePicker.hidden = YES;
 //   self.datePickerCell.hidden = YES;
    self.datePickerIsShowing = NO;
    self.reminderDatePickerIsShowing = NO;
    self.reminderMinutesDatePicker.datePickerMode = UIDatePickerModeTime;
    self.wakeUpTimeDatePicker.datePickerMode = UIDatePickerModeTime;
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [ self.dateFormatter setDateFormat:@"HH:mm"];
    
    
    self.isReminderToStopEating = true;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
        NSDate *notificationDate = [timeObject calculateTimeToStopEating:self.wakeUpTimeDatePicker.date];
        NSLog(@"Dit is het tijdstip dat gekozen is: %@", notificationDate);
        NSLog(@"Dit is de datepicker tijd: %@", self.wakeUpTimeDatePicker.date);
      //  NSLog(@"Dit is de datum nu: %@", [NSDate date]);
        UIApplication *app = [UIApplication sharedApplication];
        UILocalNotification *eatAlarm = [[UILocalNotification alloc]init];
        eatAlarm.fireDate = [NSDate dateWithTimeInterval:-57600 sinceDate:self.wakeUpTimeDatePicker.date];//notificationDate;
        NSLog(@"Dit is het alarm: %@", eatAlarm.fireDate);
        eatAlarm.timeZone = [NSTimeZone localTimeZone];
        eatAlarm.alertBody = @"Nu moet je stoppen met eten!";
        eatAlarm.alertAction = @"Stop met eten!!";
        eatAlarm.soundName = UILocalNotificationDefaultSoundName;
        eatAlarm.applicationIconBadgeNumber = [app applicationIconBadgeNumber]+1;
        [app scheduleLocalNotification:eatAlarm];
        
    }
    else
    {
        NSLog(@"nope");
    }
  
    
    
}


- (IBAction)setAlarmTime:(UIDatePicker *)sender
{
    self.wakeUpTimeLabel.text = [self.dateFormatter stringFromDate:sender.date];
    //alarmtijd naar notification sturen
    NSLog(@"Tijd is veranderd!");
    
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

#pragma mark - Table view data source


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
