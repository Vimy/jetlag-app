//
//  MainViewController.m
//  Jetlag-app
//
//  Created by Matthias Vermeulen on 25/01/15.
//  Copyright (c) 2015 Noizy. All rights reserved.
//

#import "MainViewController.h"
#import "TransitionManager.h"
#import "NotificationsViewController.h"

@interface MainViewController () <NotificationViewControllerDelegate>
{
    TransitionManager *TSManager;
}
@property (strong, nonatomic) IBOutlet UILabel *AlarmTimeLabel;
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
  
    
    TSManager = [[TransitionManager alloc]init];
    self.cancelAlarmButton.hidden = YES;
    self.fastingBeginsLabel.hidden = YES;
    self.fastingBeginsHourLabel.hidden = YES;
    
   // self.AlarmTimeLabel.text = @"08:00";
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setAlarmTimeFromSettings:(NSString *)timeString
{
    self.AlarmTimeLabel.text = timeString;
    NSLog(@"Hoi");
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   //MainViewController *toViewController = segue.destinationViewController;
  //  toViewController.transitioningDelegate = TSManager;
    NotificationsViewController *notifVC = [[NotificationsViewController alloc]init];
    notifVC.delegate = self;
    [self.navigationController pushViewController:notifVC animated:YES];
    
}


- (IBAction)unwindChangeScreen:(UIStoryboardSegue *)segue
{
    
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
