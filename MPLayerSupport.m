//
//  MPLayerSupport.m
//  MrTimer
//
//  Created by li haoxiang on 10/25/12.
//  Copyright (c) 2012 Haoxiang Li. All rights reserved.
//

#import "MPLayerSupport.h"

@implementation MPLayerSupport
@synthesize layerDelegate;

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    [self.layerDelegate supportDrawLayer:layer inContext:ctx];
}

@end
