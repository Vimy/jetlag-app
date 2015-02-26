//
//  MainViewController.h
//  Jetlag-app
//
//  Created by Matthias Vermeulen on 25/01/15.
//  Copyright (c) 2015 Noizy. All rights reserved.
//

#import "ViewController.h"

@protocol AlarmClockDelegate <NSObject>
@required
- (void)AlarmTimeDidChanged;
@end


@interface MainViewController : ViewController
@property (strong, nonatomic) IBOutlet UIButton *cancelAlarmButton;
@property (strong, nonatomic) IBOutlet UILabel *fastingBeginsLabel;
@property (strong, nonatomic) IBOutlet UILabel *fastingBeginsHourLabel;

@end
