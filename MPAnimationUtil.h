//
//  MPAnimationUtil.h
//  MrTimer
//
//  Created by li haoxiang on 10/31/12.
//  Copyright (c) 2012 Haoxiang Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CAAnimation;

@interface MPAnimationUtil : NSObject

+ (CAAnimation *)flashColor:(UIColor *)color
                      maxAlpha:(float)maxAlpha
                      minAlpha:(float)minAlpha
                  increaseTime:(float)increaseTime
                  decreaseTime:(float)decreaseTime
                    keyPath:(NSString*)keyPath;

+ (CAAnimation *)flashColor:(UIColor *)color
                   maxAlpha:(float)maxAlpha
                   minAlpha:(float)minAlpha
               increaseTime:(float)increaseTime
               decreaseTime:(float)decreaseTime
               restoreColor:(UIColor *)restoreColor
                restoreTime:(float)restoreTime
                    keyPath:(NSString*)keyPath;

@end
