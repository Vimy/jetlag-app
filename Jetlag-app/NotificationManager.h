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

- (void)createNotification:(NSDictionary *)notificationInfo;
- (void)cancelNotification:(NSString *)notificationID withNotificationID:(NSString *)cancelNotificationID;
- (void)cancelAllNotifications;


@end
