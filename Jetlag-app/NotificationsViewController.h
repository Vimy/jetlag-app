//
//  NotificationsViewController.h
//  Jetlag-app
//
//  Created by Matthias Vermeulen on 26/01/15.
//  Copyright (c) 2015 Noizy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NotificationViewControllerDelegate <NSObject>

@required
- (void)setAlarmTimeFromSettings:(NSString *)timeString;

@end

@interface NotificationsViewController : UITableViewController

@property (nonatomic, weak) id <NotificationViewControllerDelegate> delegate;

@end




