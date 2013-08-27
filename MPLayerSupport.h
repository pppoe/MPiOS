//
//  MPLayerSupport.h
//  MrTimer
//
//  Created by li haoxiang on 10/25/12.
//  Copyright (c) 2012 Haoxiang Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (MPLayerSupportDelegate)

- (void)supportDrawLayer:(CALayer *)layer inContext:(CGContextRef)ctx;

@end

@interface MPLayerSupport : NSObject

@property (nonatomic, strong) id layerDelegate;

@end
