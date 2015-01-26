//
//  NotificationsViewController.m
//  Jetlag-app
//
//  Created by Matthias Vermeulen on 26/01/15.
//  Copyright (c) 2015 Noizy. All rights reserved.
//

#import "NotificationsViewController.h"

#define kDatePickerSection 0
#define kDatePickerIndex 1
#define kDatePickerCellHeight 164
@interface NotificationsViewController ()
@property (strong, nonatomic) IBOutlet UIDatePicker *wakeUpTimeDatePicker;
@property (strong, nonatomic) IBOutlet UITableViewCell *datePickerCell;
@property (strong, nonatomic) IBOutlet UILabel *wakeUpTimeLabel;
@property (strong, nonatomic) IBOutlet UITableViewCell *setReminderTimeCell;
@property (strong, nonatomic) IBOutlet UILabel *reminderLabel;
@property (strong, nonatomic) IBOutlet UILabel *remindMeCellTextLabel;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property  BOOL datePickerIsShowing;
@end

@implementation NotificationsViewController

//http://masteringios.com/blog/2013/11/18/ios-7-in-line-uidatepicker-part-2/2/

- (void)viewDidLoad {
    [super viewDidLoad];
    self.wakeUpTimeDatePicker.hidden = YES;
 //   self.datePickerCell.hidden = YES;
    self.datePickerIsShowing = NO;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = self.tableView.rowHeight;
    
    if (indexPath.row == kDatePickerIndex & indexPath.section == 0){
        
        height = self.datePickerIsShowing ? kDatePickerCellHeight : 0.0f;
        
    }
    
    return height;
}
- (IBAction)setAlarmTime:(UIDatePicker *)sender
{
    self.wakeUpTimeLabel.text = [self.dateFormatter stringFromDate:sender.date];
    //alarmtijd naar notification sturen
    
    
}

- (IBAction)setStartOfFastNotification:(UISwitch *)sender
{
    
    
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

- (void)showDatePickerCell {
    
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

- (void)hideDatePickerCell {
    
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