//
//  RoundedCornerGradientButton.m
//  OurBrand
//
//  Created by haoxiang on 1/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MPGradientButton.h"


@implementation MPGradientButton
@synthesize label = _label;
@synthesize button = _button;
@synthesize imageView = _imageView;

- (id)initWithFrame:(CGRect)frame {    
    return [self initWithFrame:frame gradientColors:[NSArray arrayWithObjects: 
                                                     [UIColor colorWithRed:140/255.0f green:189/255.0f blue:140/255.0f alpha:1.0f],
                                                     [UIColor colorWithRed:66/255.0f green:181/255.0f blue:74/255.0f alpha:1.0f],
                                                     [UIColor colorWithRed:16/255.0f green:165/255.0f blue:33/255.0f alpha:1.0f],
                                                     [UIColor colorWithRed:25/255.0f green:156/255.0f blue:33/255.0f alpha:1.0f], nil]
                   borderColor:[UIColor blackColor] borderWith:2.0f radius:5.0f];
}

- (id)initWithFrame:(CGRect)frame gradientColors:(NSArray *)colors borderColor:(UIColor *)borderColor borderWith:(CGFloat)borderWith radius:(CGFloat)radius {
    if (self = [super initWithFrame:frame])
    {
        _colorArray = [[NSMutableArray alloc] initWithArray:colors];
        _borderColor = borderColor;
        _borderWidth = borderWith;
        _radius = radius;
        
        // Initialization code.
        self.backgroundColor = [UIColor clearColor];
        
        _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        _button.alpha = 0.1f;
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _label.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont boldSystemFontOfSize:16.0f];
        _label.shadowColor = [UIColor darkGrayColor];
        _label.shadowOffset = CGSizeMake(0, -1);
        _label.textColor = [UIColor whiteColor];
        _label.backgroundColor = [UIColor clearColor];
        _label.lineBreakMode = NSLineBreakByWordWrapping;
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        [self addSubview:_imageView];
        [self addSubview:_label];
        [self addSubview:_button];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame gradientColors:(NSArray *)colors borderWith:(CGFloat)borderWith radius:(CGFloat)radius {
    return [self initWithFrame:frame gradientColors:colors borderColor:[UIColor blackColor] borderWith:borderWith radius:radius];
}

- (id)initWithFrame:(CGRect)frame gradientColors:(NSArray *)colors {
    return [self initWithFrame:frame gradientColors:colors borderColor:[UIColor blackColor] borderWith:2.0f radius:5.0f];
}

- (void)addRoundedPathInContext:(CGContextRef)context WithRect:(CGRect)rect borderWidth:(CGFloat)borderWidth andRadius:(CGFloat)radius {
    
    CGRect newRect = CGRectMake(borderWidth, borderWidth, rect.size.width - 2*borderWidth, rect.size.height - 2*borderWidth);
    
    CGFloat midX = CGRectGetMidX(newRect);
    CGFloat midY = CGRectGetMidY(newRect);
    CGFloat minX = CGRectGetMinX(newRect);
    CGFloat minY = CGRectGetMinY(newRect);
    CGFloat maxX = CGRectGetMaxX(newRect);
    CGFloat maxY = CGRectGetMaxY(newRect);
    
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, midX, minY);
    CGContextAddArcToPoint(context, maxX, minY, maxX, midY, radius);
    CGContextAddArcToPoint(context, maxX, maxY, midX, maxY, radius);
    CGContextAddArcToPoint(context, minX, maxY, minX, midY, radius);
    CGContextAddArcToPoint(context, minX, minY, midX, minY, radius);
    CGContextClosePath(context);    
}

- (void)fillInContext:(CGContextRef)context rect:(CGRect)rect withGradient:(CGGradientRef)gradient {
    CGPoint startP = CGPointMake(rect.origin.x + rect.size.width/2.0f, rect.origin.y);
    CGPoint endP = CGPointMake(rect.origin.x + rect.size.width/2.0f, rect.origin.y + rect.size.height);    
    CGContextDrawLinearGradient(context, gradient, startP, endP, 0);    
}

- (CGGradientRef)createGradientFromColorTop:(UIColor *)colorTop colorBottom:(UIColor *)colorBottom {
    
    CGFloat colors[8];
    const CGFloat *colorComponentsTop = CGColorGetComponents(colorTop.CGColor);
    const CGFloat *colorComponentsBottom = CGColorGetComponents(colorBottom.CGColor);
    int colorTopLen = CGColorGetNumberOfComponents(colorTop.CGColor);
    int colorBottomLen = CGColorGetNumberOfComponents(colorBottom.CGColor); 
    
    //< Copy colorTop
    for (int i = 0; i < 4; i++)
    {
        colors[i] = ((i < colorTopLen) ? colorComponentsTop[i] : 1.0f);
    }

    //< Copy colorBottom
    for (int i = 0; i < 4; i++)
    {
        colors[i+4] = ((i < colorBottomLen) ? colorComponentsBottom[i] : 1.0f);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    
    CGColorSpaceRelease(colorSpace);
    
    return gradient;
}

- (void)drawRect:(CGRect)rect {

    CGContextRef context = UIGraphicsGetCurrentContext();    
    
    //< Cleanup
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //< Draw Gradients 
    CGContextSaveGState(context);

    //< Clip a RoundedCorner Rect
    [self addRoundedPathInContext:context WithRect:rect borderWidth:_borderWidth/2.0f andRadius:_radius];
        
    int numberOfColors = [_colorArray count];
    if (numberOfColors <= 1) //< Solid Color
    {
        UIColor *color = [UIColor clearColor]; //< Default Solid Color
        if (_colorArray && numberOfColors > 0)
        {
            color = [_colorArray objectAtIndex:0];
        }
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillPath(context);
    }
    else if (numberOfColors == 2) //< Single Gradient
    {
        CGContextClip(context);
        CGGradientRef gradient = [self createGradientFromColorTop:[_colorArray objectAtIndex:0]
                                                      colorBottom:[_colorArray objectAtIndex:1]];
        [self fillInContext:context rect:CGRectMake(0, 0, rect.size.width, rect.size.height)
               withGradient:gradient];
        CGGradientRelease(gradient);        
    }
    else if (numberOfColors == 3) //< Double Gradient 
    {
        CGContextClip(context);
        {
            ////< Half above
            CGGradientRef gradient = [self createGradientFromColorTop:[_colorArray objectAtIndex:0]
                                                             colorBottom:[_colorArray objectAtIndex:1]];
            [self fillInContext:context rect:CGRectMake(0, 0, rect.size.width, rect.size.height/2.0f)
                   withGradient:gradient];
            CGGradientRelease(gradient);
        }
        {
            ////< Half below
            CGGradientRef gradient = [self createGradientFromColorTop:[_colorArray objectAtIndex:1]
                                                          colorBottom:[_colorArray objectAtIndex:2]];
            [self fillInContext:context rect:CGRectMake(0, rect.size.height/2.0f, rect.size.width, rect.size.height/2.0f)
                   withGradient:gradient];
            CGGradientRelease(gradient);
        }
    }
    else // if (numberOfColors == 4) //< Double Gradient 
    {
        CGContextClip(context);
        {
            ////< Half above
            CGGradientRef gradient = [self createGradientFromColorTop:[_colorArray objectAtIndex:0]
                                                          colorBottom:[_colorArray objectAtIndex:1]];
            [self fillInContext:context rect:CGRectMake(0, 0, rect.size.width, rect.size.height/2.0f)
                   withGradient:gradient];
            CGGradientRelease(gradient);
        }
        {
            ////< Half below
            CGGradientRef gradient = [self createGradientFromColorTop:[_colorArray objectAtIndex:2]
                                                          colorBottom:[_colorArray objectAtIndex:3]];
            [self fillInContext:context rect:CGRectMake(0, rect.size.height/2.0f, rect.size.width, rect.size.height/2.0f)
                   withGradient:gradient];
            CGGradientRelease(gradient);
        }
    }
    
    CGContextRestoreGState(context);
    
    //< Border
    CGContextSaveGState(context);
    [self addRoundedPathInContext:context WithRect:rect borderWidth:_borderWidth/2.0f andRadius:_radius];
    CGContextSetStrokeColorWithColor(context, _borderColor.CGColor);
    CGContextSetLineWidth(context, _borderWidth);
    CGContextStrokePath(context);    
    CGContextRestoreGState(context);
}

- (void)layoutSubviews {
    [self bringSubviewToFront:_button];
}

#pragma mark Methods
- (void)imageClipToRadius:(CGFloat)radius {
    _imageView.clipsToBounds = YES;
    _imageView.layer.cornerRadius = radius;
}

- (void)setButtonWithColor:(UIColor *)color {
    [_colorArray removeAllObjects];
    [_colorArray addObject:color];
    [self setNeedsDisplay];
}

- (void)setButtonWithColor1:(UIColor *)color1 :(UIColor *)color2 {
    [_colorArray removeAllObjects];
    [_colorArray addObject:color1];
    [_colorArray addObject:color2];
    [self setNeedsDisplay];
}

- (void)setButtonWithColor1:(UIColor *)color1 :(UIColor *)color2 :(UIColor *)color3 {
    [_colorArray removeAllObjects];
    [_colorArray addObject:color1];
    [_colorArray addObject:color2];    
    [_colorArray addObject:color3];    
    [self setNeedsDisplay];
}

- (void)setButtonWithColor1:(UIColor *)color1 :(UIColor *)color2 :(UIColor *)color3 :(UIColor *)color4 {
    [_colorArray removeAllObjects];
    [_colorArray addObject:color1];
    [_colorArray addObject:color2];    
    [_colorArray addObject:color3];    
    [_colorArray addObject:color4];    
    [self setNeedsDisplay];
}

- (void)setButtonBorderColor:(UIColor *)color {
    _borderColor = color;
    [self setNeedsDisplay];
}

- (void)setButtonBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    [self setNeedsDisplay];
}

- (void)setButtonBorderRadius:(CGFloat)radius {
    _radius = radius;
    [self setNeedsDisplay];
}

@end
