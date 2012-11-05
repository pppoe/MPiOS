//
//  MPGlowLabel.h
//  MrTimer
//
//  Created by li haoxiang on 10/26/12.
//  Copyright (c) 2012 Haoxiang Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPLayerSupport;
@class CAGradientLayer;

@interface MPGlowLabel : UILabel {
    MPLayerSupport *mLayerSupport;
    CAGradientLayer *mUnderLayer;
}

- (void)stopGlowing;
- (void)resumeGlowing;

@end
