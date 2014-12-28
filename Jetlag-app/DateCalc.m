//
//  DateCalc.m
//  FilmData
//
//  Created by Matthias Vermeulen on 28/12/14.
//  Copyright (c) 2014 Noizy. All rights reserved.
//

#import "DateCalc.h"

@implementation DateCalc

-(NSDate *)calculateTimeToStopEating:(NSDate *)TimeToWakeUp
{
    int hoursToRemove = -16;
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc]init];
    [components setHour:hoursToRemove];
    NSDate *stopEatingDate = [gregorian dateByAddingComponents:components toDate:TimeToWakeUp options:0];

    return stopEatingDate;
    
    
}


@end

