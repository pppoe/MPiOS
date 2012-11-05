//
//  MPColorUtil.h
//  MrTimer
//
//  Created by li haoxiang on 10/24/12.
//  Copyright (c) 2012 Haoxiang Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MPColorUtil : NSObject

//< hex in ARGB
+ (UIColor*)colorFromHex:(int)hex;
+ (int)colorInHex:(UIColor *)color;
+ (void)colorComponentsFromHex:(int)hex components:(CGFloat*)components;

@end
