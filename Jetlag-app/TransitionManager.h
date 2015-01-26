//
//  TransitionManager.h
//  CustomTransition
//
//  Created by Matthias Vermeulen on 18/01/15.
//  Copyright (c) 2015 Noizy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TransitionManager : NSObject <UIViewControllerAnimatedTransitioning>



- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext;
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext;
@end
