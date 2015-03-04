//
//  NotificationManager.h
//  Jetlag-app
//
//  Created by Matthias Vermeulen on 25/02/15.
//  Copyright (c) 2015 Noizy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NotificationManager : NSObject

- (void)createNotification:(NSDate *)fireDate withNotificationID:(NSString *)notificationID;
- (void)cancelNotification:(NSString *)notificationID withNotificationID:(NSString *)cancelNotificationID;
- (void)cancelAllNotifications;


@end
