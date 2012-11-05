//
//  RoundedCornerGradientButton.h
//  OurBrand
//
//  Created by haoxiang on 1/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MPGradientButton : UIView {
    UIButton *_button;
    UILabel *_label;
    UIImageView *_imageView;
    
    NSMutableArray *_colorArray;
    UIColor *_borderColor;
    CGFloat _radius;
    CGFloat _borderWidth;
}

@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UIButton *button;
@property (nonatomic, retain) UIImageView *imageView;

- (id)initWithFrame:(CGRect)frame gradientColors:(NSArray *)colors;
- (id)initWithFrame:(CGRect)frame gradientColors:(NSArray *)colors borderWith:(CGFloat)borderWith radius:(CGFloat)radius;          
- (id)initWithFrame:(CGRect)frame gradientColors:(NSArray *)colors borderColor:(UIColor *)borderColor borderWith:(CGFloat)borderWith radius:(CGFloat)radius;          

- (void)imageClipToRadius:(CGFloat)radius;

- (void)setButtonWithColor:(UIColor *)color;
- (void)setButtonWithColor1:(UIColor *)color1 :(UIColor *)color2;
- (void)setButtonWithColor1:(UIColor *)color1 :(UIColor *)color2 :(UIColor *)color3;
- (void)setButtonWithColor1:(UIColor *)color1 :(UIColor *)color2 :(UIColor *)color3 :(UIColor *)color4;
- (void)setButtonBorderColor:(UIColor *)color;
- (void)setButtonBorderWidth:(CGFloat)borderWidth;
- (void)setButtonBorderRadius:(CGFloat)radius;

@end
