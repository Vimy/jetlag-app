//
//  NotificationManager.m
//  Jetlag-app
//
//  Created by Matthias Vermeulen on 25/02/15.
//  Copyright (c) 2015 Noizy. All rights reserved.
//

#import "NotificationManager.h"

@implementation NotificationManager

- (void)createNotification:(NSDictionary *)notificationInfo
{
    

    UIApplication *app = [UIApplication sharedApplication];
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    notification.fireDate = [notificationInfo objectForKey:@"firedate"];
    NSLog(@"Dit is het alarm: %@", notification.fireDate);
    notification.timeZone = [NSTimeZone localTimeZone];
    notification.alertBody = [notificationInfo objectForKey:@"alertBody"];
    notification.alertAction = [notificationInfo objectForKey:@"alertAction"];;
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.applicationIconBadgeNumber = [app applicationIconBadgeNumber]+1;
    [app scheduleLocalNotification:notification];

   // http://stackoverflow.com/questions/9232490/how-do-i-create-and-cancel-unique-uilocalnotification-from-a-custom-class
    
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
