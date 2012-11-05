//
//  MPGlowLabel.m
//  MrTimer
//
//  Created by li haoxiang on 10/26/12.
//  Copyright (c) 2012 Haoxiang Li. All rights reserved.
//

#import "MPGlowLabel.h"
#import "MPLayerSupport.h"
#import "MPColorUtil.h"
#import <QuartzCore/QuartzCore.h>

#define kMovingAnimationKey @"kMovingAnimationKey"

@interface MPGlowLabel ()

- (void)prepareAnimation:(CGContextRef)context;

@end

@implementation MPGlowLabel

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!mLayerSupport)
    {
        mLayerSupport = [[MPLayerSupport alloc] init];
        mLayerSupport.layerDelegate = self;        
    }
    
    self.textAlignment = NSTextAlignmentCenter;
    self.textColor = [UIColor whiteColor];
    self.textColor = [MPColorUtil colorFromHex:0xFF0367E7];
    self.backgroundColor = [UIColor clearColor];

    if (!mUnderLayer)
    {
        mUnderLayer = [CAGradientLayer layer];
        mUnderLayer.frame = self.bounds;
        mUnderLayer.delegate = mLayerSupport;
        NSArray *colors = [NSArray arrayWithObjects:
                           (id)[self.backgroundColor colorWithAlphaComponent:0.2].CGColor,
                           (id)[self.backgroundColor colorWithAlphaComponent:1].CGColor,
                           (id)[self.backgroundColor colorWithAlphaComponent:0.2].CGColor,
                           nil];
        NSArray *locations = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0],
                              [NSNumber numberWithFloat:0.5],
                              [NSNumber numberWithFloat:1],
                              nil];
        mUnderLayer.colors = colors;
        mUnderLayer.locations = locations;
        mUnderLayer.startPoint = CGPointMake(0, 0.5);
        mUnderLayer.endPoint = CGPointMake(1, 0.5);
        [self.layer addSublayer:mUnderLayer];
        self.layer.mask = mUnderLayer;
    }
    else
    {
        mUnderLayer.frame = self.bounds;
    }
    
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [mUnderLayer setNeedsDisplay];
}

- (void)supportDrawLayer:(CALayer *)layer inContext:(CGContextRef)context {
    if (layer == mUnderLayer)
    {
        UIGraphicsPushContext(context);
        
        [self prepareAnimation:context];
        
        UIGraphicsPopContext();
    }
}

- (void)prepareAnimation:(CGContextRef)context {
    
    if (![mUnderLayer animationForKey:kMovingAnimationKey])
    {
        float duration = 2;
        float gradientGap = 0.3;
        {
            CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"startPoint"];
            anim1.fillMode = kCAFillModeForwards;
            anim1.removedOnCompletion = NO;
            [anim1 setFromValue:[NSValue valueWithCGPoint:CGPointMake(0.0,0.5)]];
            [anim1 setToValue:[NSValue valueWithCGPoint:CGPointMake(1 - gradientGap,0.5)]];
            [anim1 setBeginTime:0];
            [anim1 setDuration:duration];
            
            CABasicAnimation *anim2 = [CABasicAnimation animationWithKeyPath:@"endPoint"];
            anim2.fillMode = kCAFillModeForwards;
            anim2.removedOnCompletion = NO;
            [anim2 setFromValue:[NSValue valueWithCGPoint:CGPointMake(gradientGap,0.5)]];
            [anim2 setToValue:[NSValue valueWithCGPoint:CGPointMake(1,0.5)]];
            [anim2 setBeginTime:0];
            [anim2 setDuration:duration];
            [anim2 setRepeatCount:HUGE_VALF];
            CAAnimationGroup *anim = [CAAnimationGroup animation];
            anim.animations = [NSArray arrayWithObjects:anim1, anim2, nil];
            anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            anim.duration = duration;
            anim.repeatCount = HUGE_VALF;
            [mUnderLayer addAnimation:anim forKey:kMovingAnimationKey];
        }
    }
}

- (void)stopGlowing {
    self.layer.mask = nil;
    [mUnderLayer removeAllAnimations];
}

- (void)resumeGlowing {
    self.layer.mask = mUnderLayer;
    [self setNeedsDisplay];
}

@end
