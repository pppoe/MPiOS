//
//  MPCustomView.h
//  MrTimer
//
//  Created by li haoxiang on 10/24/12.
//  Copyright (c) 2012 Haoxiang Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPCustomView;

@protocol MPCustomViewDelegate <NSObject>

- (void)drawRect:(CGRect)rect inCustomView:(MPCustomView*)view;

@end

@interface MPCustomView : UIView

@property (nonatomic) id<MPCustomViewDelegate> delegate;

@end
