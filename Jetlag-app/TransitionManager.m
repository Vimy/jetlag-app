//
//  TransitionManager.m
//  CustomTransition
//
//  Created by Matthias Vermeulen on 18/01/15.
//  Copyright (c) 2015 Noizy. All rights reserved.
//

#import "TransitionManager.h"

@implementation TransitionManager

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // When sliding the views horizontally, in and out, figure out whether we are going left or right.
    BOOL goingRight = ([transitionContext initialFrameForViewController:toView].origin.x < [transitionContext finalFrameForViewController:toView].origin.x);
    
    CGFloat travelDistance = [transitionContext containerView].bounds.size.width; //+ kChildViewPadding;
    CGAffineTransform travel = CGAffineTransformMakeTranslation (goingRight ? travelDistance : -travelDistance, 0);
    
    [[transitionContext containerView] addSubview:toView.view];
    toView.view.alpha = 0;
    toView.view.transform = CGAffineTransformInvert (travel);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.75f initialSpringVelocity:0.5f options:0x00 animations:^{
        fromView.view.transform = travel;
        fromView.view.alpha = 0;
        toView.view.transform = CGAffineTransformIdentity;
        toView.view.alpha = 1;
    } completion:^(BOOL finished) {
        fromView.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self;
}
@end
