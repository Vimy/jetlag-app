//
//  NotificationManager.m
//  Jetlag-app
//
//  Created by Matthias Vermeulen on 25/02/15.
//  Copyright (c) 2015 Noizy. All rights reserved.
//

#import "NotificationManager.h"

@implementation NotificationManager

- (void)createNotification:(NSDate *)fireDate withNotificationID:(NSString *)notificationID
{
    // userinfo adden met Objectkey @"id"
}

- (void)cancelNotification:(NSString *)notificationID withNotificationID:(NSString *)cancelNotificationID
{
    UILocalNotification *notificationTocancel = nil;
    for (UILocalNotification *aNotification in [[UIApplication sharedApplication] scheduledLocalNotifications] )
    {
        if ([[aNotification.userInfo objectForKey:@"ID"] isEqualToString:cancelNotificationID])
        {
            notificationTocancel = aNotification;
            break;
        }
    }
    
    [[UIApplication sharedApplication] cancelLocalNotification:notificationTocancel];
    
}

- (void)cancelAllNotifications
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}
@end
