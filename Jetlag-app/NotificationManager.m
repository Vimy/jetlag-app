//
//  NotificationManager.m
//  Jetlag-app
//
//  Created by Matthias Vermeulen on 25/02/15.
//  Copyright (c) 2015 Noizy. All rights reserved.
//

#import "NotificationManager.h"

@implementation NotificationManager
{
    UIApplication* objApp;
    NSArray*    oldNotifications ;
}

- (instancetype)init
{
    if (self)
    {
        objApp = [UIApplication sharedApplication];
        oldNotifications = [objApp scheduledLocalNotifications];
    }
    return self;
}

- (void)createNotification:(NSDictionary *)notificationInfo
{
    NSLog(@"Notifications: %@", oldNotifications);

    UIApplication *app = [UIApplication sharedApplication];
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    notification.fireDate = [notificationInfo objectForKey:@"firedate"];
    NSLog(@"Dit is het alarm: %@", notification.fireDate);
    notification.timeZone = [NSTimeZone localTimeZone];
    notification.alertBody = [notificationInfo objectForKey:@"alertBody"];
    notification.alertAction = [notificationInfo objectForKey:@"alertAction"];;
    
    
    notification.userInfo = notificationInfo; //[notificationInfo objectForKey:@"notificationName"];
  
   
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.applicationIconBadgeNumber = [app applicationIconBadgeNumber]+1;
    [app scheduleLocalNotification:notification];

   // http://stackoverflow.com/questions/9232490/how-do-i-create-and-cancel-unique-uilocalnotification-from-a-custom-class
    
    // userinfo adden met Objectkey @"id"
}

- (void)cancelNotificationWithNotificationID:(NSString *)cancelNotificationID
{
    NSLog(@"Called cancelNotifacations");
    
    UILocalNotification *notificationTocancel = nil;
    for (UILocalNotification *aNotification in [objApp scheduledLocalNotifications] )
    {
        if ([[aNotification.userInfo objectForKey:@"notificationName"] isEqualToString:cancelNotificationID])
        {
            notificationTocancel = aNotification;
            break;
        }
    }
    
    [objApp cancelLocalNotification:notificationTocancel];

    
}

- (void)cancelAllNotifications
{
    NSLog(@"Called cancelallNotifications");
    [objApp cancelAllLocalNotifications];
    
    NSArray *notificationsList=  [objApp scheduledLocalNotifications];
    NSLog(@"Lijst na delete: %@", notificationsList);
}
@end
