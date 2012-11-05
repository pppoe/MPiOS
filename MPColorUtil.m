//
//  MPColorUtil.m
//  MrTimer
//
//  Created by li haoxiang on 10/24/12.
//  Copyright (c) 2012 Haoxiang Li. All rights reserved.
//

#import "MPColorUtil.h"

@implementation MPColorUtil

+ (UIColor*)colorFromHex:(int)hex {
    int a = (hex & 0xFF000000) >> 24;
    int r = (hex & 0x00FF0000) >> 16;
    int g = (hex & 0x0000FF00) >> 8;
    int b = (hex & 0x000000FF);
    return [UIColor colorWithRed:r/255.0f
                           green:g/255.0f
                            blue:b/255.0f
                           alpha:a/255.0f];
}

+ (int)colorInHex:(UIColor *)color {

    CGFloat red, green, blue, alpha;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    int a = alpha*255;
    int r = red*255;
    int g = green*255;
    int b = blue*255;
    
    return (((a << 24) & 0xFF000000)
            | ((r << 16) & 0x00FF0000)
            | ((g << 8) & 0x0000FF00)
            | ((b) & 0x000000FF));
}

+ (void)colorComponentsFromHex:(int)hex components:(CGFloat*)components {
    int a = (hex & 0xFF000000) >> 24;
    int r = (hex & 0x00FF0000) >> 16;
    int g = (hex & 0x0000FF00) >> 8;
    int b = (hex & 0x000000FF);
    components[0] = r/255.0f;
    components[1] = g/255.0f;
    components[2] = b/255.0f;
    components[3] = a/255.0f;
}

@end
