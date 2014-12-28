//
//  ViewController.m
//  Jetlag-app
//
//  Created by Matthias Vermeulen on 3/11/14.
//  Copyright (c) 2014 Noizy. All rights reserved.
//

#import "ViewController.h"
#import "DateCalc.h"


@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UILabel *wakeUpTimeLabel;
@property (strong, nonatomic) DateCalc *calc;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.calc = [[DateCalc alloc]init];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)chooseWakeUpTime:(UIDatePicker *)sender
{
    NSDate *wakeUpTime = [sender date];
    NSDate *stopEatingTime;
    
    stopEatingTime = [self.calc calculateTimeToStopEating:wakeUpTime];
    
    NSLocale *usLocale = [[NSLocale alloc]
                          initWithLocaleIdentifier:@"nl_BE"];

    NSString *timeString = [[NSString alloc]
                                 initWithFormat:@"%@",
                                 [stopEatingTime descriptionWithLocale:usLocale]];
    self.wakeUpTimeLabel.text = timeString;
}

@end
