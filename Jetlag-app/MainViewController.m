//
//  MainViewController.m
//  Jetlag-app
//
//  Created by Matthias Vermeulen on 25/01/15.
//  Copyright (c) 2015 Noizy. All rights reserved.
//

#import "MainViewController.h"
#import "TransitionManager.h"

@interface MainViewController ()
{
    TransitionManager *TSManager;
}
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    TSManager = [[TransitionManager alloc]init];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MainViewController *toViewController = segue.destinationViewController;
    toViewController.transitioningDelegate = TSManager;
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
