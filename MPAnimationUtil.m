//
//  MPAnimationUtil.m
//  MrTimer
//
//  Created by li haoxiang on 10/31/12.
//  Copyright (c) 2012 Haoxiang Li. All rights reserved.
//

#import "MPAnimationUtil.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

@implementation MPAnimationUtil

+ (CAAnimation *)flashColor:(UIColor *)color
                   maxAlpha:(float)maxAlpha
                   minAlpha:(float)minAlpha
               increaseTime:(float)increaseTime
               decreaseTime:(float)decreaseTime
                    keyPath:(NSString*)keyPath {
    
    CABasicAnimation *flashAnim = [CABasicAnimation animationWithKeyPath:keyPath];
    flashAnim.fromValue = (id)[color colorWithAlphaComponent:minAlpha].CGColor;
    flashAnim.toValue = (id)[color colorWithAlphaComponent:maxAlpha].CGColor;
    flashAnim.removedOnCompletion = NO;
    flashAnim.duration = increaseTime;
    
    CABasicAnimation *flashAnim1 = [CABasicAnimation animationWithKeyPath:keyPath];
    flashAnim1.fromValue = (id)[color colorWithAlphaComponent:maxAlpha].CGColor;
    flashAnim1.toValue = (id)[color colorWithAlphaComponent:minAlpha].CGColor;
    flashAnim1.beginTime = flashAnim.duration;
    flashAnim1.removedOnCompletion = YES;
    flashAnim1.duration = decreaseTime;
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:flashAnim, flashAnim1, nil];
    animGroup.fillMode = kCAFillModeForwards;
    animGroup.duration = (increaseTime + decreaseTime);
    
    return animGroup;
}

+ (CAAnimation *)flashColor:(UIColor *)color
                   maxAlpha:(float)maxAlpha
                   minAlpha:(float)minAlpha
               increaseTime:(float)increaseTime
               decreaseTime:(float)decreaseTime
               restoreColor:(UIColor *)restoreColor
                restoreTime:(float)restoreTime
                    keyPath:(NSString*)keyPath {
    
    CABasicAnimation *flashAnim = [CABasicAnimation animationWithKeyPath:keyPath];
    flashAnim.fromValue = (id)[color colorWithAlphaComponent:minAlpha].CGColor;
    flashAnim.toValue = (id)[color colorWithAlphaComponent:maxAlpha].CGColor;
    flashAnim.removedOnCompletion = NO;
    flashAnim.duration = increaseTime;
    
    CABasicAnimation *flashAnim1 = [CABasicAnimation animationWithKeyPath:keyPath];
    flashAnim1.fromValue = (id)[color colorWithAlphaComponent:maxAlpha].CGColor;
    flashAnim1.toValue = (id)[color colorWithAlphaComponent:minAlpha].CGColor;
    flashAnim1.beginTime = flashAnim.duration;
    flashAnim1.removedOnCompletion = NO;
    flashAnim1.duration = decreaseTime;

    CABasicAnimation *flashAnimR = [CABasicAnimation animationWithKeyPath:keyPath];
    flashAnimR.fromValue = (id)[color colorWithAlphaComponent:minAlpha].CGColor;
    flashAnimR.toValue = (id)restoreColor.CGColor;
    flashAnimR.beginTime = flashAnim.duration + flashAnim1.duration;
    flashAnimR.removedOnCompletion = YES;
    flashAnimR.duration = restoreTime;

    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:flashAnim, flashAnim1, flashAnimR, nil];
    animGroup.fillMode = kCAFillModeForwards;
    animGroup.duration = (increaseTime + decreaseTime + restoreTime);
    
    return animGroup;
}

@end
